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

// MARK: - MediationGrant
struct MediationGrant: Codable {
    let id: String
    let type: String
    let endpoint: String
    let routingKeys: [String]

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case type = "@type"
        case endpoint
        case routingKeys = "routing_keys"
    }
}

// MARK: MediationGrant convenience initializers and mutators

extension MediationGrant {
    init(data: Data) throws {
        self = try jsonDecoder().decode(MediationGrant.self, from: data)
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
        endpoint: String? = nil,
        routingKeys: [String]? = nil
    ) -> MediationGrant {
        return MediationGrant(
            id: id ?? self.id,
            type: type ?? self.type,
            endpoint: endpoint ?? self.endpoint,
            routingKeys: routingKeys ?? self.routingKeys
        )
    }

    func jsonData() throws -> Data {
        return try jsonEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
