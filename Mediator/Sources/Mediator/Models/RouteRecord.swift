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

public struct RouteRecord: Codable {
    let recipientKey: String
    let connectionId, recordId: String?
    let role, state, walletId: String?
    let createdAt, updatedAt: Date?

    enum CodingKeys: String, CodingKey {
        case connectionId = "connection_id"
        case createdAt = "created_at"
        case recipientKey = "recipient_key"
        case recordId = "record_id"
        case role, state
        case updatedAt = "updated_at"
        case walletId = "wallet_id"
    }
}

public extension RouteRecord {
    init(data: Data) throws {
        self = try jsonDecoder(dateDecodingStrategy: .spaceAndInternetFormatted).decode(RouteRecord.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    func jsonData() throws -> Data {
        return try jsonEncoder(dateEncodingStrategy: .spaceAndInternetFormatted).encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}
