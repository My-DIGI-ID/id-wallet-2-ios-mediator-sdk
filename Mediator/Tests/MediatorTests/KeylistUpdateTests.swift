@testable import Mediator
import XCTest

final class KeylistUpdateTests: XCTestCase {

    func test_decode() throws {
        let sut = try KeylistUpdate(TestData.json)
        XCTAssertTrue(sut.id == "3fa85f64-5717-4562-b3fc-2c963f66afa6")
        XCTAssertTrue(sut.type == "https://didcomm.org/my-family/1.0/my-message-type")
        XCTAssertFalse(sut.updates.isEmpty)
        XCTAssertTrue(sut.updates.count == 1)
        XCTAssertTrue(sut.updates.first?.action == "add")
        XCTAssertTrue(sut.updates.first?.recipientKey == "H3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV")
    }

    func test_encode() throws {
        let rule = KeylistUpdateRule(action: "add", recipientKey: "H3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV")
        let sut = try KeylistUpdate(id: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
                                    type: "https://didcomm.org/my-family/1.0/my-message-type",
                                    updates: [rule]).jsonString()    
        XCTAssertTrue(sut == TestData.json)
    }
}

fileprivate enum TestData {
    static let json =
"""
{
  "@id" : "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "@type" : "https://didcomm.org/my-family/1.0/my-message-type",
  "updates" : [
    {
      "action" : "add",
      "recipient_key" : "H3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"
    }
  ]
}
"""
}
