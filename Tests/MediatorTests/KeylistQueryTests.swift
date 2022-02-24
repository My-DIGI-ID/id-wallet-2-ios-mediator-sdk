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

final class KeylistQueryTests: XCTestCase {
    func test_decode() throws {
        let sut = try KeylistQuery(TestData.json)
        XCTAssertTrue(sut.id == "3fa85f64-5717-4562-b3fc-2c963f66afa6")
        XCTAssertTrue(sut.type == "https://didcomm.org/my-family/1.0/my-message-type")
        XCTAssertTrue(sut.filter == ["filter": [:]])
        XCTAssertTrue(sut.paginate?.limit == 30)
        XCTAssertTrue(sut.paginate?.offset == 0)
    }

    func test_encode() throws {
        let filter: JSONValue = ["filter": [:]]
        let sut = try KeylistQuery(
            id: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
            type: "https://didcomm.org/my-family/1.0/my-message-type",
            filter: filter,
            paginate: Paginate(limit: 30, offset: 0)).jsonString()        
        XCTAssertTrue(sut == TestData.json)
    }
}

private enum TestData {
    static let json =
    """
    {
      "@id" : "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "@type" : "https://didcomm.org/my-family/1.0/my-message-type",
      "filter" : {
        "filter" : {

        }
      },
      "paginate" : {
        "limit" : 30,
        "offset" : 0
      }
    }
    """
}
