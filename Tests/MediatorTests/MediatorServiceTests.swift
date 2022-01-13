@testable import Mediator
import XCTest

final class MediatorServiceTests: XCTestCase {
    var service: MediatorService!

    override func setUpWithError() throws {
        service = MediatorService()
    }

    func test_discover_path() {
        XCTAssertTrue(MediatorRouter.discover.method == .GET)
        XCTAssertTrue(MediatorRouter.discover.url.relativePath == "/.well-known/agent-configuration")
    }

    func test_discover() async {
        do {
            let sut = try await service.discover()
            XCTAssertTrue(sut.serviceEndpoint == "https://ssi-mediator-20.esatus.com")
            XCTAssertTrue(sut.routingKey == "EYweTVBFRdwvXevGfzvj8xf9gNwQ6Cu9HgHBU2yTJAJb")
            XCTAssertTrue(sut.invitation.label == "SSI-MEDIATION-AGENT")
            XCTAssertTrue(sut.invitation.imageUrl == "https://self-ssi.com/images/ssi-logo.png")
            XCTAssertTrue(sut.invitation.serviceEndpoint == "https://ssi-mediator-20.esatus.com")
            XCTAssertNil(sut.invitation.routingKeys)
            XCTAssertTrue(sut.invitation.recipientKeys.count == 1)
            XCTAssertTrue(sut.invitation.recipientKeys.first == "CBUBWRqhJ4ePyZpo64EJvHmn3w7uTHDzdE2ov85WtMps")
            XCTAssertTrue(sut.invitation.id == "6238a33e-de3d-4b97-9c90-7198fa2c3c2a")
            XCTAssertTrue(sut.invitation.type == "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/connections/1.0/invitation")

        } catch {
            XCTFail("\(error)")
        }
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
}
