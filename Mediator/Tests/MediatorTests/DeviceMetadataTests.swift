@testable import Mediator
import XCTest

final class DeviceMetadataTests: XCTestCase {

    func test_decode() throws {
        let sut = try DeviceMetadata(TestData.json)
        XCTAssertTrue(sut.push == "NotificationHubIDW")
        XCTAssertTrue(sut.createdAt == 1639162094)
    }

    func test_encode() throws {
        let sut = try DeviceMetadata(push: "NotificationHubIDW", createdAt: 1639162094).jsonString()
        print(sut!)
        XCTAssertTrue(sut == TestData.json)
    }
}

private enum TestData {
    static let json: String = """
    {
      "CreatedAt" : 1639162094,
      "Push" : "NotificationHubIDW"
    }
    """
}
