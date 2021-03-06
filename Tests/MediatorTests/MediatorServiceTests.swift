@testable import Mediator
@testable import Aries
import XCTest

final class MediatorServiceTests: XCTestCase {
    let id = "ID"
    let key = "KEY"
    let genesis = Bundle.module.path(forResource: "idw_eesditest", ofType: nil, inDirectory: "Resource")!
    
    let agentService = DefaultAgentService()
    let mediatorService = MediatorService(urlString: "https://mediator.dev.essid-demo.com/.well-known/agent-configuration")

    override func setUp() async throws {
        try await super.setUp()
        
        MediatorService.mobileSecret = "vU70ZrK1b5dyYNPq2T4jYngb6d4IkPYJ"
        
        try await Aries.agent.initialize(with: id, key, genesis)
        try await Aries.agent.open(with: id, key)
        // Set the first master secret to enable credential handling
        try await Aries.agent.run {
            try? await Aries.provisioning.update(id, with: $0)
            try? await Aries.provisioning.update(Owner(name: "ID Wallet"), with: $0)
            try? await Aries.provisioning.update(Endpoint(uri: "https://www.example.com"), with: $0)
        }
    }
    
    override func tearDown() async throws {
        try await Aries.agent.close()
        try await Aries.agent.destroy(with: id, key)
        try await super.tearDown()
    }
    
    func test_discover_path() {
        XCTAssertTrue(MediatorRouter.discover.method == .GET)
        XCTAssertTrue(MediatorRouter.discover.url.relativePath == "/.well-known/agent-configuration")
    }
    
    func testConnection() async throws {

        try await mediatorService.connect()
    }
    
    func testCreateInbox() async throws {
        do {

            try await mediatorService.connect()
            
            let response = try await mediatorService.createInbox(with: TestData.deviceValidation)
            print(response)
        } catch {
            print(error)
            try await Aries.agent.destroy(with: id, key)
        }
    }
    
    func testAddRoute() async throws {
        do {
            try await mediatorService.connect()
            try await mediatorService.addRoute(destination: UUID().uuidString)
        } catch {
            XCTFail("\(error)")
            try await Aries.agent.destroy(with: id, key)
        }
    }
    
    func testGetInboxItems() async throws {
        do {
            try await mediatorService.connect()
            _ = try await mediatorService.createInbox(with: TestData.deviceValidation)
            let response = try await mediatorService.getInboxItems()
            print(response)
        } catch {
            print(error)
            try await Aries.agent.destroy(with: id, key)
        }
    }
    
    // Unhandled exception has been thrown: A value must be provided. (Parameter 'id')
    // This test should be done with inbox items which are current not available
//    func testDeleteInboxItems() async throws {
//        do {
//            try await mediatorService.connect()
//            try await mediatorService.deleteInboxItems(inboxItemIds: ["1"])
//        } catch {
//            XCTFail("\(error)")
//            try await Aries.agent.destroy(with: id, key)
//        }
//    }
    
    func testAddDeviceInfo() async throws {
        do {
            try await mediatorService.connect()
            _ = try await mediatorService.createInbox(with: TestData.deviceValidation)
            try await mediatorService.addDeviceInfo(
                deviceId: "DeviceID",
                deviceMetadata: DeviceMetadata(
                    push: "push",
                    createdAt: Date().timeIntervalSince1970))
        } catch {
            try await Aries.agent.destroy(with: id, key)
        }
    }
}

// swiftlint:disable indentation_width
private enum TestData {
    
    static let configuration =
        """
        {
          "ServiceEndpoint": "https://mediator.dev.essid-demo.com",
          "RoutingKey": "A5k9RAU121Wr3gXtg6yZHnZTGbzs6DPQTa6Vn3Q1kSWP",
          "Invitation": {
            "label": "SSI-MEDIATION-AGENT",
            "imageUrl": "https://digital-enabling.eu/assets/images/logo.png",
            "serviceEndpoint": "https://mediator.dev.essid-demo.com",
            "routingKeys": null,
            "recipientKeys": [
              "DMd5kppGXbHFHHVGdYKs8FcfsMtgx9NL3agbGmVSPehc"
            ],
            "@id": "5dafc4aa-1e23-46de-a393-b34901fde23b",
            "@type": "did:sov:BzCbsNYhMrjHiqZDTUASHg;spec/connections/1.0/invitation"
          }
        }
        """
    
    static let mobileSecrect = "vU70ZrK1b5dyYNPq2T4jYngb6d4IkPYJ"
    static let deviceValidation = "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"
}
