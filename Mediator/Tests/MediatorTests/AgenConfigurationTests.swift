@testable import Mediator
import XCTest

final class AgentConfigurationTests: XCTestCase {
    func test_decode() throws {
        let sut = try AgentConfiguration(TestData.json)
        XCTAssertTrue(sut.serviceEndpoint == "https://ssi-mediator-20.esatus.com")
        XCTAssertTrue(sut.routingKey == "EYweTVBFRdwvXevGfzvj8xf9gNwQ6Cu9HgHBU2yTJAJb")
        XCTAssertTrue(sut.invitation.label == "SSI-MEDIATION-AGENT")
        XCTAssertTrue(sut.invitation.imageUrl == "https://self-ssi.com/images/ssi-logo.png")
        XCTAssertTrue(sut.invitation.serviceEndpoint ==  "https://ssi-mediator-20.esatus.com")
        XCTAssertNil(sut.invitation.routingKeys)
        XCTAssertTrue(sut.invitation.recipientKeys.count == 1)
        XCTAssertTrue(sut.invitation.recipientKeys.first == "CBUBWRqhJ4ePyZpo64EJvHmn3w7uTHDzdE2ov85WtMps")
        XCTAssertTrue(sut.invitation.id == "6238a33e-de3d-4b97-9c90-7198fa2c3c2a")
        XCTAssertTrue(sut.invitation.type == "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/connections/1.0/invitation")
    }

    // We don't need to encode the Agent Configuration as it comes from .well-known
}

private enum TestData {
    static let json =
        """
        {
          "ServiceEndpoint" : "https://ssi-mediator-20.esatus.com",
          "RoutingKey" : "EYweTVBFRdwvXevGfzvj8xf9gNwQ6Cu9HgHBU2yTJAJb",
          "Invitation" : {
            "label" : "SSI-MEDIATION-AGENT",
            "imageUrl" : "https://self-ssi.com/images/ssi-logo.png",
            "serviceEndpoint" : "https://ssi-mediator-20.esatus.com",
            "routingKeys" : null,
            "recipientKeys" : [
              "CBUBWRqhJ4ePyZpo64EJvHmn3w7uTHDzdE2ov85WtMps"
            ],
            "@id" : "6238a33e-de3d-4b97-9c90-7198fa2c3c2a",
            "@type" : "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/connections/1.0/invitation"
          }
        }
        """
}
