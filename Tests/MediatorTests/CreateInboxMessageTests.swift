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

final class CreateInboxMessageTests: XCTestCase {
    func test_decode() throws {
        let sut = try CreateInboxMessage(TestData.json)
        XCTAssertTrue(sut.id == "fdc65ce9-5122-4315-8f66-eedba2f4b5d0")
        XCTAssertTrue(sut.type == "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/basic-routing/1.0/create-inbox")
        XCTAssertTrue(sut.metadata.mobileSecret == "SECRET")
        XCTAssertTrue(sut.metadata.deviceValidation == "DEVICE-VALIDATION-RESULT")
        XCTAssertTrue(sut.metadata.deviceVendor == "iOS")
    }

    func test_decode_should_fail() throws {
        XCTAssertThrowsError(try CreateInboxMessage(TestData.jsonMissingType))
    }

    func test_encode() throws {
        let metaData = Metadata(mobileSecret: "SECRET", deviceValidation: "DEVICE-VALIDATION-RESULT")
        let sut = try CreateInboxMessage(
            id: "fdc65ce9-5122-4315-8f66-eedba2f4b5d0",
            metadata: metaData).jsonString()
        XCTAssertTrue(sut == TestData.json)
    }
}

// swiftlint:disable indentation_width
private enum TestData {
    static let json =
"""
{
  "@id" : "fdc65ce9-5122-4315-8f66-eedba2f4b5d0",
  "@type" : "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/basic-routing/1.0/create-inbox",
  "metadata" : {
    "Device-Validation" : "DEVICE-VALIDATION-RESULT",
    "Device-Vendor" : "iOS",
    "Mobile-Secret" : "SECRET"
  }
}
"""

    static let jsonMissingType =
    """
        {
          "@id" : "fdc65ce9-5122-4315-8f66-eedba2f4b5d0"
          "@type" : "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/basic-routing/1.0/create-inbox",
          "metadata" : {
            "Device-Validation" : "\u{0}"
        }
    }
    """
}
