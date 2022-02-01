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
