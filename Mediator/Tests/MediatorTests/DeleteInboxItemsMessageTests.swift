@testable import Mediator
import XCTest

final class DeleteInboxItemsMessageTests: XCTestCase {

    func test_decode() throws {
        let sut = try DeleteInboxItemsMessage(TestData.json)
        XCTAssertTrue(sut.id == "3fa85f64-5717-4562-b3fc-2c963f66afa6")
        XCTAssertTrue(sut.type == "https://didcomm.org/basic-routing/1.0/delete-inbox-items")
        XCTAssertTrue(sut.inboxItemIds.count == 3)
        XCTAssertTrue(sut.inboxItemIds.first == "1")
        XCTAssertTrue(sut.inboxItemIds[1] == "2")
        XCTAssertTrue(sut.inboxItemIds.last == "3")
    }

    func test_encode() throws {
        let sut = try DeleteInboxItemsMessage(id: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
                                              type: "https://didcomm.org/basic-routing/1.0/delete-inbox-items",
                                              inboxItemIds: ["1", "2", "3"]).jsonString()
        print(sut!)
        XCTAssertTrue(sut == TestData.json)
    }
}

private enum TestData {
    static let json: String = """
    {
      "@id" : "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "@type" : "https://didcomm.org/basic-routing/1.0/delete-inbox-items",
      "inboxItemIds" : [
        "1",
        "2",
        "3"
      ]
    }
    """
}
