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

// MARK: - CreateInboxMessage
public struct CreateInboxMessage: Codable {
    public let id: String
    public let type: String
    public let metadata: Metadata

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case type = "@type"
        case metadata
    }

    public init(id: String, type: String, metadata: Metadata) {
        self.id = id
        self.type = type
        self.metadata = metadata
    }
}

// MARK: CreateInboxMessage convenience initializers and mutators

public extension CreateInboxMessage {
    init(data: Data) throws {
        self = try jsonDecoder().decode(CreateInboxMessage.self, from: data)
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
        id: String? = nil,
        type: String? = nil,
        metadata: Metadata? = nil
    ) -> CreateInboxMessage {
        return CreateInboxMessage(
            id: id ?? self.id,
            type: type ?? self.type,
            metadata: metadata ?? self.metadata
        )
    }

    func jsonData() throws -> Data {
        return try jsonEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
