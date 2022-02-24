//
// Copyright 2022 Bundesrepublik Deutschland
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
// the License. You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//

import Foundation
import Aries

private enum Constants {
    enum Tags {
        static let connectionId = "MediatorConnectionId"
        static let mediatorInboxId = "MediatorInboxId"
        static let mediatorInboxKey = "MediatorInboxKey"
    }

    enum HttpHeaderFields {
        static let createInbox = ["IsInboxCreation": "True"]
        static let addRoute = ["IsAddRouting": "True"]
        static let getInboxItems = ["IsGetInboxItems": "True"]
        static let deleteInboxItems = ["IsDeleteInboxItems": "True"]
        static let addDeviceInfo = ["IsDeviceRegistration": "True"]
    }
}

public protocol MediatorProtocol {
    func connect() async throws
    func createInbox(with validation: String) async throws -> CreateInboxResponseMessage
    func addRoute(id: String, destination: String) async throws
    func getInboxItems(id: String) async throws -> GetInboxItemsResponseMessage
    func deleteInboxItems(id: String, inboxItemIds: [String]) async throws
    func addDeviceInfo(id: String, deviceId: String, deviceMetadata: DeviceMetadata) async throws
    func setServiceURL(string: String) throws
}

public class MediatorService: MediatorProtocol {
    private(set) lazy var networking = Networking()
    static public var mobileSecret: String = ""

    public init(urlString: String?) {
        guard
            let string = urlString,
            let url = URL(string: string) else { return }
        Networking.hostURL = url
    }

    /// Creates a connection to the designated Mediator agent
    /// It first disovers the inivation and creates the corresponding request. After receiving and processing the response message the needed porovisioning record is created and updated
    public func connect() async throws {
        try await Aries.agent.run {
            let configuration = try await discover()
            let pair = try await Aries.connection
                .createRequest(for: configuration.invitation, with: $0)

            let record = pair.1
            var request = pair.0
            request.transport = TransportDecorator(mode: .all)

            let message = MessageRequest(
                message: request,
                recipientKeys: configuration.invitation.recipientKeys,
                senderKey: record.myVerkey,
                endpoint: configuration.invitation.endpoint
            )

            let response: ConnectionResponseMessage = try await Aries.message
                .sendReceive(message, with: $0.wallet)
                .message

            let connectionID = try await Aries.connection.processResponse(response, with: record, $0)

            // Creates a provisioning record if it doesn't exist
            var provisioningRecord = try await Aries.provisioning.getRecord(with: $0)
            provisioningRecord.tags[Constants.Tags.connectionId] = connectionID
            provisioningRecord.endpoint = Endpoint(
                uri: configuration.serviceEndpoint,
                did: nil,
                verkeys: [configuration.routingKey]
            )
            
            try await Aries.record.update(provisioningRecord, in: $0.wallet)
        }
    }

    /// Creates an Mediator Inbox.
    ///
    /// Before calling this function it's necessary to create the Metadata object
    ///
    /// ````
    /// let attestionObject = try await IDWalletSecurity().getAttestionObject(challenge: challenge)
    /// let metadata = Metadata(mobileSecret: mobileSecret, deviceValidation: attestionObject)
    /// ````
    /// - Parameters:
    ///   - id: An identifier
    ///   - metadata: the metadata description
    /// - Returns: ``CreateInboxResponseMessage``
    public func createInbox(with validation: String) async throws -> CreateInboxResponseMessage {
        try await Aries.agent.run {
            let metaData = Metadata(mobileSecret: MediatorService.mobileSecret, deviceValidation: validation)
            var createInboxMessage = CreateInboxMessage(metadata: metaData)
            createInboxMessage.transport = .init(mode: .all)

            var provisioningRecord = try await Aries.provisioning.getRecord(with: $0)
            guard let connectionID = provisioningRecord.tags[Constants.Tags.connectionId] else {
                throw MediatorError.noConnection
            }
            let connection = try await Aries.record.get(ConnectionRecord.self, for: connectionID, from: $0.wallet)

            guard let service = connection.theirDocument().services?.first else {
                throw MediatorError.noService
            }
            let request = MessageRequest(
                message: createInboxMessage,
                recipientKeys:
                    service.recipientKeys ?? [],
                senderKey: connection.myVerkey,
                headers: Constants.HttpHeaderFields.createInbox,
                endpoint: service.endpoint)

            let response: CreateInboxResponseMessage = try await Aries.message.sendReceive(request, with: $0.wallet).message
            provisioningRecord.tags[Constants.Tags.mediatorInboxId] = response.inboxId
            provisioningRecord.tags[Constants.Tags.mediatorInboxKey] = response.inboxKey
            try await Aries.record.update(provisioningRecord, in: $0.wallet)

            return response
        }
    }

    public func addRoute(id: String = UUID().uuidString, destination: String) async throws {
        try await Aries.agent.run {

            let provisioningRecord = try await Aries.provisioning.getRecord(with: $0)
            guard let connectionID = provisioningRecord.tags[Constants.Tags.connectionId] else {
                throw MediatorError.noConnection
            }
            let connection = try await Aries.record.get(ConnectionRecord.self, for: connectionID, from: $0.wallet)

            guard let service = connection.theirDocument().services?.first else {
                return
            }
            let message = AddRouteMessage(routeDestination: destination)
            let request = MessageRequest(
                message: message,
                recipientKeys: service.recipientKeys ?? [],
                senderKey: connection.myVerkey,
                headers: Constants.HttpHeaderFields.addRoute,
                endpoint: service.endpoint)

            try await Aries.message.send(request, with: $0.wallet)
        }
    }

    /// Get the inbox items from the inbox
    /// - Parameter id: Inbox identifier
    /// - Returns: the inbox items
    public func getInboxItems(id: String = UUID().uuidString) async throws -> GetInboxItemsResponseMessage {
        try await Aries.agent.run {

            let provisioningRecord = try await Aries.provisioning.getRecord(with: $0)
            guard let connectionID = provisioningRecord.tags[Constants.Tags.connectionId] else {
                throw MediatorError.noConnection
            }
            let connection = try await Aries.record.get(ConnectionRecord.self, for: connectionID, from: $0.wallet)

            guard let service = connection.theirDocument().services?.first else {
                throw MediatorError.noService
            }
            let message = GetInboxItemsMessage()
            let request = MessageRequest(
                message: message,
                recipientKeys: service.recipientKeys ?? [],
                senderKey: connection.myVerkey,
                headers: Constants.HttpHeaderFields.getInboxItems,
                endpoint: service.endpoint)

            let response: GetInboxItemsResponseMessage = try await Aries.message.sendReceive(request, with: $0.wallet).message
            return response
        }
    }

    /// Delete inbox items
    /// - Parameters:
    ///   - id: Inbox ID
    ///   - inboxItemIds: Array of message id's to delete
    public func deleteInboxItems(id: String = UUID().uuidString, inboxItemIds: [String]) async throws {
        try await Aries.agent.run {

            let provisioningRecord = try await Aries.provisioning.getRecord(with: $0)
            guard let connectionID = provisioningRecord.tags[Constants.Tags.connectionId] else {
                throw MediatorError.noConnection
            }
            let connection = try await Aries.record.get(ConnectionRecord.self, for: connectionID, from: $0.wallet)

            guard let service = connection.theirDocument().services?.first else {
                throw MediatorError.noService
            }
            let message = DeleteInboxItemsMessage(inboxItemIds: inboxItemIds)
            let request = MessageRequest(
                message: message,
                recipientKeys: service.recipientKeys ?? [],
                senderKey: connection.myVerkey,
                headers: Constants.HttpHeaderFields.deleteInboxItems,
                endpoint: service.endpoint)
            try await Aries.message.send(request, with: $0.wallet)
        }
    }

    public func addDeviceInfo(id: String = UUID().uuidString, deviceId: String, deviceMetadata: DeviceMetadata) async throws {
        try await Aries.agent.run {

            let provisioningRecord = try await Aries.provisioning.getRecord(with: $0)
            guard let connectionID = provisioningRecord.tags[Constants.Tags.connectionId] else {
                throw MediatorError.noConnection
            }
            let connection = try await Aries.record.get(ConnectionRecord.self, for: connectionID, from: $0.wallet)

            guard let service = connection.theirDocument().services?.first else {
                throw MediatorError.noService
            }

            let message = AddDeviceInfoMessage(id: id, deviceId: deviceId, deviceMetadata: deviceMetadata)
            let request = MessageRequest(
                message: message,
                recipientKeys:
                    service.recipientKeys ?? [],
                senderKey: connection.myVerkey,
                headers: Constants.HttpHeaderFields.addDeviceInfo,
                endpoint: service.endpoint)
            try await Aries.message.send(request, with: $0.wallet)
        }
    }

    public func setServiceURL(string: String) throws {
        guard let url = URL(string: string) else {
            throw MediatorError.invalidHostURL
        }
        Networking.hostURL = url
    }
}
