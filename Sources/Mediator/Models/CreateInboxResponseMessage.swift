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

// MARK: - CreateInboxResponseMessage

public struct CreateInboxResponseMessage: Message {

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case type = "@type"
        case inboxId = "InboxId"
        case inboxKey = "InboxKey"
    }

    public let id: String
    public let type: String

    public let inboxId: String
    public let inboxKey: String

    public init(id: String = "", type: String = "", inboxId: String, inboxKey: String) {
        self.id = id
        self.type = type
        self.inboxId = inboxId
        self.inboxKey = inboxKey
    }
}

// MARK: CreateInboxResponseMessage convenience initializers and mutators

public extension CreateInboxResponseMessage {
    init(data: Data) throws {
        self = try JSONDecoder.decoder().decode(CreateInboxResponseMessage.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    func jsonData() throws -> Data {
        return try JSONEncoder.encoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}
