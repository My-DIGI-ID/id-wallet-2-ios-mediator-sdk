@testable import Mediator
import XCTest

final class MediationCreateRequestTests: XCTestCase {

    func test_decode() throws {
        let sut = try MediationCreateRequest(TestData.json)
        XCTAssertFalse(sut.mediatorTerms.isEmpty)
        XCTAssertFalse(sut.recipientTerms.isEmpty)
        XCTAssertTrue(sut.mediatorTerms.first == "string")
        XCTAssertTrue(sut.recipientTerms.first == "string")
    }

    func test_encode() throws {
        let sut = try MediationCreateRequest(mediatorTerms: ["string"], recipientTerms: ["string"]).jsonString()
        XCTAssertTrue(sut == TestData.json)
    }
}

fileprivate enum TestData {
    static let json =
"""
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
