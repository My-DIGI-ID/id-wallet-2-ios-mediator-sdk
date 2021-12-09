@testable import Mediator
import XCTest

final class KeyListsTests: XCTestCase {

    func test_decode() throws {
        let sut = try KeyLists(TestData.json)
        XCTAssertFalse(sut.results.isEmpty)
        XCTAssertTrue(sut.results.count == 1)
        XCTAssertTrue(sut.results.first?.connectionId == "string")
        XCTAssertTrue(sut.results.first?.createdAt == "2021-11-17 15:54:50Z")
        XCTAssertTrue(sut.results.first?.recipientKey == "string")
        XCTAssertTrue(sut.results.first?.recordId == "string")
        XCTAssertTrue(sut.results.first?.role == "string")
        XCTAssertTrue(sut.results.first?.state == "active")
        XCTAssertTrue(sut.results.first?.updatedAt == "2021-11-17 15:54:50Z")
        XCTAssertTrue(sut.results.first?.walletId == "string")
    }

    func test_encode() throws {
        let record = RouteRecord(connectionId: "string",
                                 createdAt: "2021-11-17 15:54:50Z",
                                 recipientKey: "string",
                                 recordId: "string",
                                 role: "string",
                                 state: "active",
                                 updatedAt: "2021-11-17 15:54:50Z",
                                 walletId: "string")
        let sut = try KeyLists(results: [record]).jsonString()
        XCTAssertTrue(sut == TestData.json)
    }
}

fileprivate enum TestData {
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
