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

public protocol MediatorProtocol {
    func createInbox(id: String, metadata: Metadata) async throws -> CreateInboxResponseMessage
    func addRoute(id: String, destination: String) async throws
    func getInboxItems(id: String) async throws -> GetInboxItemsResponseMessage
    func deleteInboxItems(id: String, inboxItemIds: [String]) async throws
    func addDeviceInfo(id: String, deviceId: String, deviceMetadata: DeviceMetadata) async throws
    func setServiceURL(string: String) throws
}

public class MediatorService: MediatorProtocol {
    private(set) lazy var networking = Networking()

    public init(urlString: String? = nil) {
        guard let string = urlString,
        let url = URL(string: string) else { return }
        Networking.hostURL = url
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
    public func createInbox(id: String, metadata: Metadata) async throws -> CreateInboxResponseMessage {
        let request = MediatorRouter.createInbox(id: id, metadata: metadata).urlRequest()
        let (data, _) = try await networking.session.data(for: request)
        return try CreateInboxResponseMessage(data: data)
    }

    public func addRoute(id: String, destination: String) async throws {
        let request = MediatorRouter.addRoute(id: id, destination: destination).urlRequest()
        _ = try await networking.session.data(for: request)
    }

    public func getInboxItems(id: String) async throws -> GetInboxItemsResponseMessage {
        let request = MediatorRouter.getInboxItems(id: id).urlRequest()
        let (data, _) = try await networking.session.data(for: request)
        return try GetInboxItemsResponseMessage(data: data)
    }

    public func deleteInboxItems(id: String, inboxItemIds: [String]) async throws {
        let request = MediatorRouter.deleteInboxItems(id: id, inboxItemIds: inboxItemIds).urlRequest()
        _ = try await networking.session.data(for: request)
    }

    public func addDeviceInfo(id: String, deviceId: String, deviceMetadata: DeviceMetadata) async throws {
        let request = MediatorRouter.addDeviceInfo(id: id, deviceId: deviceId, deviceMetadata: deviceMetadata).urlRequest()
        _ = try await networking.session.data(for: request)
    }

    public func setServiceURL(string: String) throws {
        guard let url = URL(string: string) else {
            throw MediatorError.invalidHostURL
        }
        Networking.hostURL = url
    }
}
