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

// MARK: - Metadata
public struct Metadata: Codable {
    public let mobileSecret, deviceValidation: String

    enum CodingKeys: String, CodingKey {
        case mobileSecret = "mobile-secret"
        case deviceValidation = "device-validation"
    }

    public init(mobileSecret: String, deviceValidation: String) {
        self.mobileSecret = mobileSecret
        self.deviceValidation = deviceValidation
    }
}

// MARK: Metadata convenience initializers and mutators

public extension Metadata {
    init(data: Data) throws {
        self = try jsonDecoder().decode(Metadata.self, from: data)
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
        mobileSecret: String? = nil,
        deviceValidation: String? = nil
    ) -> Metadata {
        return Metadata(
            mobileSecret: mobileSecret ?? self.mobileSecret,
            deviceValidation: deviceValidation ?? self.deviceValidation
        )
    }

    func jsonData() throws -> Data {
        return try jsonEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}