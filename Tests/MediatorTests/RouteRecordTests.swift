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

final class RouteRecordTests: XCTestCase {
    func test_decode() throws {
        let expectedDate = Calendar(identifier: .iso8601)
            .date(from: DateComponents(
                timeZone: TimeZone(abbreviation: "GMT"),
                year: 2021,
                month: 11,
                day: 17,
                hour: 15,
                minute: 54,
                second: 50))
        let sut = try RouteRecord(TestData.json)

        XCTAssertTrue(sut.connectionId == "string")
        XCTAssertTrue(sut.createdAt == expectedDate)
        XCTAssertTrue(sut.recipientKey == "string")
        XCTAssertTrue(sut.recordId == "string")
        XCTAssertTrue(sut.role == "string")
        XCTAssertTrue(sut.state == "active")
        XCTAssertTrue(sut.updatedAt == expectedDate)
        XCTAssertTrue(sut.walletId == "string")
    }

    func test_encode() throws {
        let expectedDate = Calendar(identifier: .iso8601)
            .date(from: DateComponents(
                timeZone: TimeZone(abbreviation: "GMT"),
                year: 2021,
                month: 11,
                day: 17,
                hour: 15,
                minute: 54,
                second: 50))
        let sut = try RouteRecord(
            recipientKey: "string",
            connectionId: "string",
            recordId: "string",
            role: "string",
            state: "active",
            walletId: "string",
            createdAt: expectedDate,
            updatedAt: expectedDate).jsonString()

        XCTAssertTrue(sut == TestData.json)
    }
}

private enum TestData {
    static let json =
    """
    {
      "connection_id" : "string",
      "created_at" : "2021-11-17 15:54:50Z",
      "recipient_key" : "string",
      "record_id" : "string",
      "role" : "string",
      "state" : "active",
      "updated_at" : "2021-11-17 15:54:50Z",
      "wallet_id" : "string"
    }
    """
}
