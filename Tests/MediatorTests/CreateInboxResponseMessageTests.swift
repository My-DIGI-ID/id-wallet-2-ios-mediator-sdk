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

final class CreateInboxResponseMessageTests: XCTestCase {
    func test_decode() throws {
        let sut = try CreateInboxResponseMessage(TestData.json)

        XCTAssertTrue(sut.inboxId == "3fa85f64-5717-4562-b3fc-2c963f66afa6")
        XCTAssertTrue(sut.inboxKey == "https://didcomm.org/my-family/1.0/my-message-type")
    }

    func test_encode() throws {
        let sut = try CreateInboxResponseMessage(
            inboxId: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            inboxKey: "https://didcomm.org/my-family/1.0/my-message-type")
            .jsonString()

        XCTAssertTrue(sut == TestData.json)
    }
}

private enum TestData {
    static let json: String =
    """
    {
        "inboxId" : "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "inboxKey" : "https://didcomm.org/my-family/1.0/my-message-type"
    }
    """
}
