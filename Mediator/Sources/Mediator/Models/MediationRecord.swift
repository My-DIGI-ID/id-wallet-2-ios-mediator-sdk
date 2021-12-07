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

public struct MediationRecord: Codable {
    public let connectionId, createdAt, endpoint, mediationId: String
    public let mediatorTerms, recipientTerms: [String]
    public let role: String
    public let routingKeys: [String]
    public let state, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case connectionId = "connection_id"
        case createdAt = "created_at"
        case endpoint
        case mediationId = "mediation_id"
        case mediatorTerms = "mediator_terms"
        case recipientTerms = "recipient_terms"
        case role
        case routingKeys = "routing_keys"
        case state
        case updatedAt = "updated_at"
    }

    public init(connectionId: String, createdAt: String, endpoint: String, mediationId: String, mediatorTerms: [String], recipientTerms: [String], role: String, routingKeys: [String], state: String, updatedAt: String) {
        self.connectionId = connectionId
        self.createdAt = createdAt
        self.endpoint = endpoint
        self.mediationId = mediationId
        self.mediatorTerms = mediatorTerms
        self.recipientTerms = recipientTerms
        self.role = role
        self.routingKeys = routingKeys
        self.state = state
        self.updatedAt = updatedAt
    }
}

// MARK: MediationRecord convenience initializers and mutators

public extension MediationRecord {
    init(data: Data) throws {
        self = try jsonDecoder().decode(MediationRecord.self, from: data)
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
        connectionId: String? = nil,
        createdAt: String? = nil,
        endpoint: String? = nil,
        mediationId: String? = nil,
        mediatorTerms: [String]? = nil,
        recipientTerms: [String]? = nil,
        role: String? = nil,
        routingKeys: [String]? = nil,
        state: String? = nil,
        updatedAt: String? = nil
    ) -> MediationRecord {
        return MediationRecord(
            connectionId: connectionId ?? self.connectionId,
            createdAt: createdAt ?? self.createdAt,
            endpoint: endpoint ?? self.endpoint,
            mediationId: mediationId ?? self.mediationId,
            mediatorTerms: mediatorTerms ?? self.mediatorTerms,
            recipientTerms: recipientTerms ?? self.recipientTerms,
            role: role ?? self.role,
            routingKeys: routingKeys ?? self.routingKeys,
            state: state ?? self.state,
            updatedAt: updatedAt ?? self.updatedAt
        )
    }

    func jsonData() throws -> Data {
        return try jsonEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
