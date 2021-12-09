@testable import Mediator
import XCTest

final class AdminMediationDenyTests: XCTestCase {
    func test_decode() throws {
        let sut = try AdminMediationDeny(TestData.json)
        XCTAssertFalse(sut.mediatorTerms.isEmpty)
        XCTAssertFalse(sut.recipientTerms.isEmpty)
        XCTAssertTrue(sut.mediatorTerms.first == "string")
        XCTAssertTrue(sut.recipientTerms.first == "string")
    }

    func test_encode() throws {
        let sut = try AdminMediationDeny(mediatorTerms: ["string"], recipientTerms: ["string"]).jsonString()
        XCTAssertTrue(sut == TestData.json)
    }
}

private enum TestData {
    static let json: String = """
    {
      "mediator_terms" : [
        "string"
      ],
      "recipient_terms" : [
        "string"
      ]
    }
    """
}
