@testable import Mediator
import XCTest

final class CreateInboxResponseMessageTests: XCTestCase {

    func test_decode() throws {
        let sut = try CreateInboxResponseMessage(TestData.json)

        XCTAssertTrue(sut.inboxId == "3fa85f64-5717-4562-b3fc-2c963f66afa6")
        XCTAssertTrue(sut.inboxKey == "https://didcomm.org/my-family/1.0/my-message-type")
    }

    func test_encode() throws {
        let sut = try CreateInboxResponseMessage(inboxId: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
                                                 inboxKey: "https://didcomm.org/my-family/1.0/my-message-type")
            .jsonString()

        XCTAssertTrue(sut == TestData.json)
    }
}

private enum TestData {
    static let json: String = """
    {
      "inboxId" : "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "inboxKey" : "https://didcomm.org/my-family/1.0/my-message-type"
    }
    """
}
