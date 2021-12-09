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

// MARK: - AgentConfiguration
public struct AgentConfiguration: Codable {
    public let serviceEndpoint: String
    public let routingKey: String
    public let invitation: Invitation

    enum CodingKeys: String, CodingKey {
        case serviceEndpoint = "ServiceEndpoint"
        case routingKey = "RoutingKey"
        case invitation = "Invitation"
    }

    public init(serviceEndpoint: String, routingKey: String, invitation: Invitation) {
        self.serviceEndpoint = serviceEndpoint
        self.routingKey = routingKey
        self.invitation = invitation
    }
}

// MARK: AgentConfiguration convenience initializers and mutators

public extension AgentConfiguration {
    init(data: Data) throws {
        self = try jsonDecoder().decode(AgentConfiguration.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        serviceEndpoint: String? = nil,
        routingKey: String? = nil,
        invitation: Invitation? = nil
    ) -> AgentConfiguration {
        return AgentConfiguration(
            serviceEndpoint: serviceEndpoint ?? self.serviceEndpoint,
            routingKey: routingKey ?? self.routingKey,
            invitation: invitation ?? self.invitation
        )
    }

    func jsonData() throws -> Data {
        return try jsonEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}