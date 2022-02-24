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

final class AdminMediationDenyTests: XCTestCase {
    func test_decode() throws {
        let sut = try AdminMediationDeny(TestData.json)
        XCTAssertFalse(sut.mediatorTerms.isEmpty)
        XCTAssertFalse(sut.recipientTerms.isEmpty)
        XCTAssertTrue(sut.mediatorTerms.first == "string")
        XCTAssertTrue(sut.recipientTerms.first == "string")
    }

    func test_encode() throws {
        let sut = try AdminMediationDeny(mediatorTerms: ["string"], recipientTerms: ["string"]).jsonString()        
        XCTAssertTrue(sut == TestData.json)
    }
}

// swiftlint:disable indentation_width

private enum TestData {
    static let json: String =
    """
    {
      "mediator_terms" : [
        "string"
      ],
      "recipient_terms" : [
        "string"
      ]
    }
    """
}
