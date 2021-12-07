@testable import Mediator
import XCTest

final class MediationRecordTests: XCTestCase {

    func test_decode() throws {
        let sut = try MediationRecord(TestData.json)
        XCTAssertTrue(sut.connectionId == "string")
    }

    func test_encode() throws {
        let sut = try MediationRecord(connectionId: "string",
                                     createdAt: "2021-11-17 15:54:50Z",
                                     endpoint: "string",
                                     mediationId: "string",
                                     mediatorTerms: ["string"],
                                     recipientTerms: ["string"],
                                     role: "string",
                                     routingKeys: ["H3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"],
                                     state: "active",
                                  updatedAt: "2021-11-17 15:54:50Z").jsonString()
        XCTAssertTrue(sut == TestData.json)
    }
}

fileprivate enum TestData {
    static let json =
"""
{
  "connection_id" : "string",
  "created_at" : "2021-11-17 15:54:50Z",
  "endpoint" : "string",
  "mediation_id" : "string",
  "mediator_terms" : [
    "string"
  ],
  "recipient_terms" : [
    "string"
  ],
  "role" : "string",
  "routing_keys" : [
    "H3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"
  ],
  "state" : "active",
  "updated_at" : "2021-11-17 15:54:50Z"
}
"""
}
