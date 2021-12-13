@testable import Mediator
import XCTest

final class GetInboxItemsResponseMessageTests: XCTestCase {
    func test_decode() throws {
        let sut = try GetInboxItemsResponseMessage(TestData.json)
        XCTAssertTrue(sut.items.count == 1)
        XCTAssertTrue(sut.items.first?.data == "string")
        XCTAssertTrue(sut.items.first?.timestamp == 1_639_158_204)
    }

    func test_encode() throws {
        let sut = try GetInboxItemsResponseMessage(items: [
            InboxItemMessage(data: "string", timestamp: 1_639_158_204)
        ]).jsonString()
        XCTAssertTrue(sut == TestData.json)
    }
}

private enum TestData {
    static let json: String = """
    {
      "items" : [
        {
          "data" : "string",
          "timestamp" : 1639158204
        }
      ]
    }
    """
}
