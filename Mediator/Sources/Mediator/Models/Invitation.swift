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

// MARK: - Invitation
public struct Invitation: Codable {
    public let label: String
    public let imageUrl: String
    public let serviceEndpoint: String
    public let routingKeys: [String]?
    public let recipientKeys: [String]
    public let id, type: String

    enum CodingKeys: String, CodingKey {
        case label, imageUrl, serviceEndpoint, routingKeys, recipientKeys
        case id = "@id"
        case type = "@type"
    }

    public init(label: String, imageUrl: String, serviceEndpoint: String, routingKeys: [String]?, recipientKeys: [String], id: String, type: String) {
        self.label = label
        self.imageUrl = imageUrl
        self.serviceEndpoint = serviceEndpoint
        self.routingKeys = routingKeys
        self.recipientKeys = recipientKeys
        self.id = id
        self.type = type
    }
}

// MARK: Invitation convenience initializers and mutators

public extension Invitation {
    init(data: Data) throws {
        self = try jsonDecoder().decode(Invitation.self, from: data)
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
        label: String? = nil,
        imageUrl: String? = nil,
        serviceEndpoint: String? = nil,
        routingKeys: [String]? = nil,
        recipientKeys: [String]? = nil,
        id: String? = nil,
        type: String? = nil
    ) -> Invitation {
        return Invitation(
            label: label ?? self.label,
            imageUrl: imageUrl ?? self.imageUrl,
            serviceEndpoint: serviceEndpoint ?? self.serviceEndpoint,
            routingKeys: routingKeys ?? self.routingKeys,
            recipientKeys: recipientKeys ?? self.recipientKeys,
            id: id ?? self.id,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try jsonEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}