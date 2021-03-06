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

final class DeleteInboxItemsMessageTests: XCTestCase {
    func test_decode() throws {
        let sut = try DeleteInboxItemsMessage(TestData.json)
        XCTAssertTrue(sut.id == "3fa85f64-5717-4562-b3fc-2c963f66afa6")
        XCTAssertTrue(sut.type == "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/basic-routing/1.0/delete-inbox-items")
        XCTAssertTrue(sut.inboxItemIds.count == 3)
        XCTAssertTrue(sut.inboxItemIds.first == "1")
        XCTAssertTrue(sut.inboxItemIds[1] == "2")
        XCTAssertTrue(sut.inboxItemIds.last == "3")
    }

    func test_encode() throws {
        let sut = try DeleteInboxItemsMessage(
            id: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            inboxItemIds: ["1", "2", "3"]).jsonString()
        XCTAssertTrue(sut == TestData.json)
    }
}

// swiftlint:disable indentation_width
private enum TestData {
    static let json: String =
    """
    {
      "@id" : "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "@type" : "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/basic-routing/1.0/delete-inbox-items",
      "inboxItemIds" : [
        "1",
        "2",
        "3"
      ]
    }
    """
}
