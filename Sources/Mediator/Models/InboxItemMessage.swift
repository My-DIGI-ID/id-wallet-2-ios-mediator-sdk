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

// MARK: - InboxItemMessage

public struct InboxItemMessage: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case type = "@type"
        case data = "Data"
        case timestamp = "Timestamp"
    }

    public let id: String
    public let type: String?
    public let data: String
    public let timestamp: Int
    
    public init(id: String, type: String, data: String, timestamp: Int) {
        self.id = id
        self.type = type
        self.data = data
        self.timestamp = timestamp
    }
}

// MARK: InboxItemMessage convenience initializers and mutators

public extension InboxItemMessage {
    init(data: Data) throws {
        self = try JSONDecoder.decoder().decode(InboxItemMessage.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    func jsonData() throws -> Data {
        return try JSONEncoder.encoder(dateEncodingStrategy: .secondsSince1970).encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}
