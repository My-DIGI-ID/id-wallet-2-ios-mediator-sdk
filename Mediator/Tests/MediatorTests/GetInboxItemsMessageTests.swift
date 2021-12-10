@testable import Mediator
import XCTest

final class GetInboxItemsMessageTests: XCTestCase {

    func test_decode() throws {
        let sut = try GetInboxItemsMessage(TestData.json)
        XCTAssertTrue(sut.id == "3fa85f64-5717-4562-b3fc-2c963f66afa6")
        XCTAssertTrue(sut.type == "https://didcomm.org/basic-routing/1.0/get-inbox-items")
    }

    func test_encode() throws {
        let sut = try GetInboxItemsMessage(id: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
                                           type: "https://didcomm.org/basic-routing/1.0/get-inbox-items").jsonString()
        XCTAssertTrue(sut == TestData.json)
    }
}

private enum TestData {
    static let json: String = """
    {
      "@id" : "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "@type" : "https://didcomm.org/basic-routing/1.0/get-inbox-items"
    }
    """
}
