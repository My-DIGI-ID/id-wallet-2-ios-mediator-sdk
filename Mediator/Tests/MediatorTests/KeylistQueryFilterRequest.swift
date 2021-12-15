@testable import Mediator
import XCTest

final class KeylistQueryFilterRequestTests: XCTestCase {
    func test_decode() throws {
        let sut = try KeylistQueryFilterRequest(TestData.json)
        XCTAssertTrue(sut.filter == [:])
    }

    func test_encode() throws {
        let value: JSONValue = [:]
        let sut = try KeylistQueryFilterRequest(filter: value).jsonString()
        XCTAssertTrue(sut == TestData.json)
    }
}

private enum TestData {
    static let json =
        """
        {
          "filter" : {

          }
        }
        """
}
