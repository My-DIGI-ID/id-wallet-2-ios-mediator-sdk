@testable import Mediator
import XCTest

final class RouteRecordTests: XCTestCase {
    func test_decode() throws {
        let sut = try RouteRecord(TestData.json)
        XCTAssertTrue(sut.connectionId == "string")
        XCTAssertTrue(sut.createdAt == "2021-11-17 15:54:50Z")
        XCTAssertTrue(sut.recipientKey == "string")
        XCTAssertTrue(sut.recordId == "string")
        XCTAssertTrue(sut.role == "string")
        XCTAssertTrue(sut.state == "active")
        XCTAssertTrue(sut.updatedAt == "2021-11-17 15:54:50Z")
        XCTAssertTrue(sut.walletId == "string")
    }

    func test_encode() throws {
        let sut = try RouteRecord(connectionId: "string",
                                  createdAt: "2021-11-17 15:54:50Z",
                                  recipientKey: "string",
                                  recordId: "string",
                                  role: "string",
                                  state: "active",
                                  updatedAt: "2021-11-17 15:54:50Z",
                                  walletId: "string").jsonString()
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
