@testable import Mediator
import XCTest

final class DeviceMetadataTests: XCTestCase {
    func test_decode() throws {
        let sut = try XCTUnwrap(DeviceMetadata(TestData.json), "Unable to get DeviceMetadata")
        XCTAssertTrue(sut.push == "NotificationHubIDW")
        XCTAssertTrue(sut.createdAt == 1_639_395_437)
    }

    func test_encode() throws {
        let sut = try DeviceMetadata(push: "NotificationHubIDW", createdAt: 1_639_395_437).jsonString()
        XCTAssertTrue(sut == TestData.json)
    }
}

private enum TestData {
    static let json: String = """
    {
      "CreatedAt" : 1639395437,
      "Push" : "NotificationHubIDW"
    }
    """
}
