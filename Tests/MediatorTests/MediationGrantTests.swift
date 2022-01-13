@testable import Mediator
import XCTest

final class MediationGrantTests: XCTestCase {
    func test_decode() throws {
        let sut = try MediationGrant(TestData.json)
        XCTAssertTrue(sut.id == "3fa85f64-5717-4562-b3fc-2c963f66afa6")
        XCTAssertTrue(sut.type == "https://didcomm.org/my-family/1.0/my-message-type")
        XCTAssertTrue(sut.endpoint == "http://192.168.56.102:8020/")
        XCTAssertTrue(sut.routingKeys.count == 1)
        XCTAssertTrue(sut.routingKeys.first == "string")
    }

    func test_encode() throws {
        let sut = try MediationGrant(id: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
                                     type: "https://didcomm.org/my-family/1.0/my-message-type",
                                     endpoint: "http://192.168.56.102:8020/",
                                     routingKeys: ["string"]).jsonString()
        XCTAssertTrue(sut == TestData.json)
    }
}

private enum TestData {
    static let json =
        """
        {
          "@id" : "3fa85f64-5717-4562-b3fc-2c963f66afa6",
          "@type" : "https://didcomm.org/my-family/1.0/my-message-type",
          "endpoint" : "http://192.168.56.102:8020/",
          "routing_keys" : [
            "string"
          ]
        }
        """
}
