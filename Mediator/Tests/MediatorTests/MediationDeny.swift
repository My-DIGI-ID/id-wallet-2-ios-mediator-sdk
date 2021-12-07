@testable import Mediator
import XCTest

final class MediationDenyTests: XCTestCase {

    func test_decode() throws {
        let sut = try MediationDeny(TestData.json)
        XCTAssertTrue(sut.id == "3fa85f64-5717-4562-b3fc-2c963f66afa6")
    }

    func test_encode() throws {        
        let sut = try MediationDeny(id: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
                                    type: "https://didcomm.org/my-family/1.0/my-message-type",
                                    mediatorTerms: ["string"], recipientTerms: ["string"]).jsonString()
        XCTAssertTrue(sut == TestData.json)
    }
}

fileprivate enum TestData {
    static let json =
"""
{
  "@id" : "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "@type" : "https://didcomm.org/my-family/1.0/my-message-type",
  "mediator_terms" : [
    "string"
  ],
  "recipient_terms" : [
    "string"
  ]
}
"""
}
