//
// Copyright 2022 Bundesrepublik Deutschland
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
// the License. You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//

@testable import Mediator
import XCTest

final class AddDeviceInfoMessageTests: XCTestCase {
    func test_decode() throws {
        let expectedDate = TimeInterval(1_639_395_437)
        let sut = try AddDeviceInfoMessage(TestData.json)
        XCTAssertTrue(sut.id == "3fa85f64-5717-4562-b3fc-2c963f66afa6")
        XCTAssertTrue(sut.type == "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/basic-routing/1.0/add-device-info")
        XCTAssertTrue(sut.deviceId == "deviceId")
        XCTAssertTrue(sut.deviceVendor == "iOS")
        XCTAssertTrue(sut.deviceMetadata.push == "NotificationHubIDW")
        XCTAssertTrue(sut.deviceMetadata.createdAt == expectedDate)
    }
    
    func test_encode() throws {
        let expectedDate = TimeInterval(1_639_395_437)
        let sut = try AddDeviceInfoMessage(
            id: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            deviceId: "deviceId",
            deviceMetadata: DeviceMetadata(
                push: "NotificationHubIDW",
                createdAt: expectedDate)).jsonString()
        XCTAssertTrue(sut == TestData.json)
    }
}

private enum TestData {
    static let json: String =
    // swiftlint:disable:next indentation_width
    """
    {
      "@id" : "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "@type" : "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/basic-routing/1.0/add-device-info",
      "deviceId" : "deviceId",
      "deviceMetadata" : {
        "CreatedAt" : 1639395437,
        "Push" : "NotificationHubIDW"
      },
      "deviceVendor" : "iOS"
    }
    """
}
