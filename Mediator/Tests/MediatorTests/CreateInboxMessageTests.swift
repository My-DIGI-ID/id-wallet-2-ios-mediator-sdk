@testable import Mediator
import XCTest

final class CreateInboxMessageTests: XCTestCase {
    func test_decode() throws {
        let sut = try CreateInboxMessage(TestData.json)
        XCTAssertTrue(sut.id == "fdc65ce9-5122-4315-8f66-eedba2f4b5d0")
        XCTAssertTrue(sut.type == "https://didcomm.org/basic-routing/1.0/create-inbox")
        XCTAssertTrue(sut.metadata.mobileSecret == "SECRET")
        XCTAssertTrue(sut.metadata.deviceValidation == "DEVICE-VALIDATION-RESULT")
    }

    func test_decode_should_fail() throws {
        XCTAssertThrowsError(try CreateInboxMessage(TestData.json_missing_type))
    }

    func test_encode() throws {
        let metaData = Metadata(mobileSecret: "SECRET", deviceValidation: "DEVICE-VALIDATION-RESULT")
        let sut = try CreateInboxMessage(id: "fdc65ce9-5122-4315-8f66-eedba2f4b5d0",
                                     type: "https://didcomm.org/basic-routing/1.0/create-inbox",
                                     metadata: metaData).jsonString()
        print(sut!)
        XCTAssertTrue(sut == TestData.json)
    }
}

private enum TestData {
    static let json =
        """
        {
          "@id" : "fdc65ce9-5122-4315-8f66-eedba2f4b5d0",
          "@type" : "https://didcomm.org/basic-routing/1.0/create-inbox",
          "metadata" : {
            "Device-Validation" : "DEVICE-VALIDATION-RESULT",
            "Mobile-Secret" : "SECRET"
          }
        }
        """

    static let json_missing_type =
        """
        {
          "@id" : "fdc65ce9-5122-4315-8f66-eedba2f4b5d0"
          "@type" : "https://didcomm.org/basic-routing/1.0/create-inbox",
          "metadata" : {
            "Device-Validation" : "\u{0}"
          }
        }
        """
}
