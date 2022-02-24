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

@testable import Mediator
import XCTest

final class MediationGrantTests: XCTestCase {
    func test_decode() throws {
        let sut = try MediationGrant(TestData.json)
        XCTAssertTrue(sut.id == "3fa85f64-5717-4562-b3fc-2c963f66afa6")
        XCTAssertTrue(sut.type == "https://didcomm.org/my-family/1.0/my-message-type")
        XCTAssertTrue(sut.endpoint == "http://192.168.56.102:8020/")
        XCTAssertTrue(sut.routingKeys.count == 1)
        XCTAssertTrue(sut.routingKeys.first == "string")
    }

    func test_encode() throws {
        let sut = try MediationGrant(
            id: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            type: "https://didcomm.org/my-family/1.0/my-message-type",
            endpoint: "http://192.168.56.102:8020/",
            routingKeys: ["string"]).jsonString()
        XCTAssertTrue(sut == TestData.json)        
    }
}

private enum TestData {
    static let json =
    """
    {
      "@id" : "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "@type" : "https://didcomm.org/my-family/1.0/my-message-type",
      "endpoint" : "http://192.168.56.102:8020/",
      "routing_keys" : [
        "string"
      ]
    }
    """
}
