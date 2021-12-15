@testable import Mediator
import XCTest

final class AddRouteMessageTests: XCTestCase {
    func test_decode() throws {
        let sut = try AddRouteMessage(TestData.json)
        XCTAssertTrue(sut.id == "3fa85f64-5717-4562-b3fc-2c963f66afa6")
        XCTAssertTrue(sut.type == "https://didcomm.org/basic-routing/1.0/add-route")
        XCTAssertTrue(sut.routeDestination == "string")
    }

    func test_encode() throws {
        let sut = try AddRouteMessage(id: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
                                      type: "https://didcomm.org/basic-routing/1.0/add-route",
                                      routeDestination: "string").jsonString()
        XCTAssertTrue(sut == TestData.json)
    }
}

private enum TestData {
    static let json: String = """
    {
      "@id" : "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "@type" : "https://didcomm.org/basic-routing/1.0/add-route",
      "routeDestination" : "string"
    }
    """
}
