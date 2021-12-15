@testable import Mediator
import XCTest

final class MediationListTests: XCTestCase {
    func test_decode() throws {
        let sut = try MediationList(TestData.json)
        let expectedDate = Calendar(identifier: .iso8601)
            .date(from: DateComponents(timeZone: TimeZone(abbreviation: "GMT"),
                                       year: 2021,
                                       month: 11,
                                       day: 17,
                                       hour: 15,
                                       minute: 54,
                                       second: 50))

        XCTAssertTrue(sut.results.count == 1)
        XCTAssertTrue(sut.results.first?.connectionId == "string")
        XCTAssertTrue(sut.results.first?.createdAt == expectedDate)
        XCTAssertTrue(sut.results.first?.endpoint == "string")
        XCTAssertTrue(sut.results.first?.mediationId == "string")
        XCTAssertTrue(sut.results.first?.state == "active")
        XCTAssertTrue(sut.results.first?.updatedAt == expectedDate)
        XCTAssertTrue(sut.results.first?.mediatorTerms?.count == 1)
        XCTAssertTrue(sut.results.first?.recipientTerms?.count == 1)
        XCTAssertTrue(sut.results.first?.mediatorTerms?.first == "string")
        XCTAssertTrue(sut.results.first?.recipientTerms?.first == "string")
        XCTAssertTrue(sut.results.first?.routingKeys?.count == 1)
        XCTAssertTrue(sut.results.first?.routingKeys?.first == "H3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV")
    }

    func test_encode() throws {
        let expectedDate = Calendar(identifier: .iso8601)
            .date(from: DateComponents(timeZone: TimeZone(abbreviation: "GMT"),
                                       year: 2021,
                                       month: 11,
                                       day: 17,
                                       hour: 15,
                                       minute: 54,
                                       second: 50))
        let record = MediationRecord(connectionId: "string",
                                     role: "string",
                                     endpoint: "string",
                                     mediationId: "string",
                                     mediatorTerms: ["string"],
                                     recipientTerms: ["string"],
                                     routingKeys: ["H3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"],
                                     state: "active",
                                     createdAt: expectedDate,
                                     updatedAt: expectedDate)
        let sut = try MediationList(results: [record]).jsonString()
        XCTAssertTrue(sut == TestData.json)
    }
}

private enum TestData {
    static let json =
        """
        {
          "results" : [
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
          ]
        }
        """
}
