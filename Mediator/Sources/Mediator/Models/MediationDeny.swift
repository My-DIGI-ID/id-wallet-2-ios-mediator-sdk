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

// MARK: - MediationDeny

struct MediationDeny: Codable {
    let id: String
    let type: String
    let mediatorTerms, recipientTerms: [String]

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case type = "@type"
        case mediatorTerms = "mediator_terms"
        case recipientTerms = "recipient_terms"
    }
}

// MARK: MediationDeny convenience initializers and mutators

extension MediationDeny {
    init(data: Data) throws {
        self = try JSONDecoder.decoder().decode(MediationDeny.self, from: data)
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
        mediatorTerms: [String]? = nil,
        recipientTerms: [String]? = nil
    ) -> MediationDeny {
        return MediationDeny(
            id: id ?? self.id,
            type: type ?? self.type,
            mediatorTerms: mediatorTerms ?? self.mediatorTerms,
            recipientTerms: recipientTerms ?? self.recipientTerms
        )
    }

    func jsonData() throws -> Data {
        return try JSONEncoder.encoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}
