@testable import Mediator
import XCTest

final class AddDeviceInfoMessageTests: XCTestCase {

    func test_decode() throws {
        let sut = try AddDeviceInfoMessage(TestData.json)
        XCTAssertTrue(sut.id == "3fa85f64-5717-4562-b3fc-2c963f66afa6")
        XCTAssertTrue(sut.type == "https://didcomm.org/basic-routing/1.0/add-device-info")
        XCTAssertTrue(sut.deviceId == "deviceId")
        XCTAssertTrue(sut.deviceVendor == "iOS")
        XCTAssertTrue(sut.deviceMetadata.push == "NotificationHubIDW")
        XCTAssertTrue(sut.deviceMetadata.createdAt == 1639162094)
    }

    func test_encode() throws {
        let sut = try AddDeviceInfoMessage(id: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
                                           type: "https://didcomm.org/basic-routing/1.0/add-device-info",
                                           deviceId: "deviceId",
                                           deviceVendor: "iOS",
                                           deviceMetadata: DeviceMetadata(push: "NotificationHubIDW", createdAt: 1639162094)).jsonString()
        print(sut!)
        XCTAssertTrue(sut == TestData.json)
    }
}

private enum TestData {
    static let json: String = """
    {
      "@id" : "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "@type" : "https://didcomm.org/basic-routing/1.0/add-device-info",
      "deviceId" : "deviceId",
      "deviceMetadata" : {
        "CreatedAt" : 1639162094,
        "Push" : "NotificationHubIDW"
      },
      "deviceVendor" : "iOS"
    }
    """
}
