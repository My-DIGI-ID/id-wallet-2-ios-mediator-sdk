@testable import Mediator
import XCTest

final class KeylistUpdateRuleTests: XCTestCase {

    func test_decode() throws {
        let sut = try KeylistUpdateRule(TestData.json)

        XCTAssertTrue(sut.action == .add)
        XCTAssertTrue(sut.recipientKey == "H3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV")
    }

    func test_encode() throws {
        let sut = try KeylistUpdateRule(action: .add,
                                        recipientKey: "H3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV")
            .jsonString()
        XCTAssertTrue(sut == TestData.json)
    }
}

private enum TestData {
    static let json =
        """
        {
          "action" : "add",
          "recipient_key" : "H3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"
        }
        """
}
