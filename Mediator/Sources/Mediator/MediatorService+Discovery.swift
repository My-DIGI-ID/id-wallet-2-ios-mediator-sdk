/*
 * Copyright 2021 Bundesrepublik Deutschland
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
 * an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 */

import Foundation

public protocol Discoverable {
    func discover() async throws -> AgentConfiguration
}

extension MediatorService: Discoverable {
    /// Performs an async network discover request retrieving the mediator information
    /// - Returns: AgentConfiguration
    public func discover() async throws -> AgentConfiguration {
        let (data, _) = try await networking.session.data(for: MediatorRouter.discover.request)
        let decoded = try JSONDecoder.decoder().decode(AgentConfiguration.self, from: data)
        return decoded
    }
}

public protocol MediatorProtocol {
    func createInbox(id: String, metadata: Metadata, challenge: Data) async throws -> CreateInboxResponseMessage
    func addRoute(id: String, destination: String) async throws
    func getInboxItems(id: String) async throws -> GetInboxItemsResponseMessage
    func deleteInboxItems(id: String, inboxItemIds: [String]) async throws
    func addDeviceInfo(id: String, deviceId: String, deviceMetadata: DeviceMetadata) async throws
}

extension MediatorService: MediatorProtocol {
    public func createInbox(id: String, metadata: Metadata, challenge: Data) async throws -> CreateInboxResponseMessage {
        let attestionObject = try await IDWalletSecurity().getAttestionObject(challenge: challenge)
        let request = MediatorRouter.createInbox(id: id, metadata: metadata).urlRequest()
        let (data, _) = try await networking.session.data(for: request)
        return try CreateInboxResponseMessage(data: data)
    }

    public func addRoute(id: String, destination: String) async throws {
        let request = MediatorRouter.addRoute(id: id, destination: destination).urlRequest()
        let (_, _) = try await networking.session.data(for: request)
    }

    public func getInboxItems(id: String) async throws -> GetInboxItemsResponseMessage {
        let request = MediatorRouter.getInboxItems(id: id).urlRequest()
        let (data, _) = try await networking.session.data(for: request)
        return try GetInboxItemsResponseMessage(data: data)
    }

    public func deleteInboxItems(id: String, inboxItemIds: [String]) async throws {
        let request = MediatorRouter.deleteInboxItems(id: id, inboxItemIds: inboxItemIds).urlRequest()
        let (_, _) = try await networking.session.data(for: request)
    }

    public func addDeviceInfo(id: String, deviceId: String, deviceMetadata: DeviceMetadata) async throws {
        let request = MediatorRouter.addDeviceInfo(id: id, deviceId: deviceId, deviceMetadata: deviceMetadata).urlRequest()
        let (_, _) = try await networking.session.data(for: request)
    }
}
