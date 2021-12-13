@testable import Mediator
import XCTest

final class KeyListsTests: XCTestCase {

    func test_decode() throws {
        let expectedDate = Calendar(identifier: .iso8601)
            .date(from: DateComponents(timeZone: TimeZone(abbreviation: "GMT"),
                                       year: 2021,
                                       month: 11,
                                       day: 17,
                                       hour: 15,
                                       minute: 54,
                                       second: 50))

        let sut = try KeyLists(TestData.json)
        XCTAssertFalse(sut.results.isEmpty)
        XCTAssertTrue(sut.results.count == 1)
        XCTAssertTrue(sut.results.first?.connectionId == "string")
        XCTAssertTrue(sut.results.first?.createdAt == expectedDate)
        XCTAssertTrue(sut.results.first?.recipientKey == "string")
        XCTAssertTrue(sut.results.first?.recordId == "string")
        XCTAssertTrue(sut.results.first?.role == "string")
        XCTAssertTrue(sut.results.first?.state == "active")
        XCTAssertTrue(sut.results.first?.updatedAt == expectedDate)
        XCTAssertTrue(sut.results.first?.walletId == "string")
    }

    func test_encode() throws {
        let expectedDate = Calendar(identifier: .iso8601)
            .date(from: DateComponents(timeZone: TimeZone(abbreviation: "GMT"),
                                       year: 2021,
                                       month: 11,
                                       day: 17,
                                       hour: 15,
                                       minute: 54,
                                       second: 50))
        let record = RouteRecord(recipientKey: "string",
                                 connectionId: "string",
                                 recordId: "string",
                                 role: "string",
                                 state: "active",
                                 walletId: "string",
                                 createdAt: expectedDate,
                                 updatedAt: expectedDate)
        let sut = try KeyLists(results: [record]).jsonString()
        XCTAssertTrue(sut == TestData.json)
    }
}

private enum TestData {
    static let json =
        """
        {
          "results" : [
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
          ]
        }
        """
}
