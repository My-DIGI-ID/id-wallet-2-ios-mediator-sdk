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
    public let connectionId: String
    public let role: String
    public let endpoint, mediationId: String?
    public let mediatorTerms, recipientTerms: [String]?
    public let routingKeys: [String]?
    public let state: String?
    public let createdAt, updatedAt: Date?

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
}

// MARK: MediationRecord convenience initializers and mutators

public extension MediationRecord {
    init(data: Data) throws {
        self = try JSONDecoder.decoder(dateDecodingStrategy: .spaceAndInternetFormatted)
            .decode(MediationRecord.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    func jsonData() throws -> Data {
        return try JSONEncoder.encoder(dateEncodingStrategy: .spaceAndInternetFormatted)
            .encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}
