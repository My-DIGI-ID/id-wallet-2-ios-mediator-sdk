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

final class KeylistQueryFilterRequestTests: XCTestCase {
    func test_decode() throws {
        let sut = try KeylistQueryFilterRequest(TestData.json)

        // swiftlint:disable:next empty_collection_literal
        XCTAssertTrue(sut.filter == [:])
    }

    func test_encode() throws {
        let value: JSONValue = [:]
        let sut = try KeylistQueryFilterRequest(filter: value).jsonString()
        XCTAssertTrue(sut == TestData.json)
    }
}

private enum TestData {
    static let json =
    """
    {
        "filter" : {
        }
    }
    """
}
