@testable import Mediator
import XCTest

final class PaginateTests: XCTestCase {
    func test_decode() throws {
        let sut = try Paginate(TestData.json)
        XCTAssertTrue(sut.limit == 30)
        XCTAssertTrue(sut.offset == 0)
    }

    func test_encode() throws {
        let sut = try Paginate(limit: 30, offset: 0).jsonString()
        XCTAssertTrue(sut == TestData.json)
    }
}

private enum TestData {
    static let json =
        """
        {
          "limit" : 30,
          "offset" : 0
        }
        """
}
