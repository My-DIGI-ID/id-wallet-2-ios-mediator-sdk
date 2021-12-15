@testable import Mediator
import XCTest

final class KeylistUpdateRequestTests: XCTestCase {
    func test_decode() throws {
        let sut = try KeylistUpdateRequest(TestData.json)
        XCTAssertFalse(sut.updates.isEmpty)
        XCTAssertTrue(sut.updates.count == 1)
        XCTAssertTrue(sut.updates.first?.action == .add)
        XCTAssertTrue(sut.updates.first?.recipientKey == "H3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV")
    }

    func test_encode() throws {
        let rule = KeylistUpdateRule(action: .add, recipientKey: "H3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV")
        let sut = try KeylistUpdateRequest(updates: [rule]).jsonString()
        XCTAssertTrue(sut == TestData.json)
    }
}

private enum TestData {
    static let json =
        """
        {
          "updates" : [
            {
              "action" : "add",
              "recipient_key" : "H3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"
            }
          ]
        }
        """
}
