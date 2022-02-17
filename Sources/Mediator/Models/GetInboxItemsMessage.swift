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

private enum Constants {
//    static let messageType: String = "https://didcomm.org/basic-routing/1.0/get-inbox-items"
    static let messageType: String = "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/basic-routing/1.0/get-inbox-items"
}

// MARK: - GetInboxItemsMessage

public struct GetInboxItemsMessage: Message {

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case type = "@type"
        case transport = "~transport"
    }

    public let id: String
    public let type: String
    /// Decorator for the response mode
    public var transport: TransportDecorator?

    public init(id: String = UUID().uuidString) {
        self.id = id
        self.type = Constants.messageType
        self.transport = .init(mode: .all)
    }
}

// MARK: GetInboxItemsMessage convenience initializers and mutators

public extension GetInboxItemsMessage {
    init(data: Data) throws {
        self = try JSONDecoder.decoder().decode(GetInboxItemsMessage.self, from: data)
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
