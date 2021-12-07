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
    let connectionId, createdAt, recipientKey, recordId: String
    let role, state, updatedAt, walletId: String

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
        self = try jsonDecoder().decode(RouteRecord.self, from: data)
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
        recipientKey: String? = nil,
        recordId: String? = nil,
        role: String? = nil,
        state: String? = nil,
        updatedAt: String? = nil,
        walletId: String? = nil
    ) -> RouteRecord {
        return RouteRecord(
            connectionId: connectionId ?? self.connectionId,
            createdAt: createdAt ?? self.createdAt,
            recipientKey: recipientKey ?? self.recipientKey,
            recordId: recordId ?? self.recordId,
            role: role ?? self.role,
            state: state ?? self.state,
            updatedAt: updatedAt ?? self.updatedAt,
            walletId: walletId ?? self.walletId
        )
    }

    func jsonData() throws -> Data {
        return try jsonEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}
