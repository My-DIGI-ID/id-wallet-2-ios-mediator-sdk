@testable import Mediator
import XCTest

final class MediatorRouterTests: XCTestCase {
    func test_create_inbox_request() {
        let expectedMetaData = Metadata(mobileSecret: "SECRET", deviceValidation: "DEVICE-VALIDATION-RESULT")
        let expectedId = "fdc65ce9-5122-4315-8f66-eedba2f4b5d0"
        let sut = MediatorRouter.createInbox(id: expectedId, metadata: expectedMetaData).urlRequest()

        XCTAssertTrue(sut.allHTTPHeaderFields?.contains(where: { $0.key == "IsInboxCreation" && $0.value == "True" }) ?? false)
        XCTAssertTrue(sut.url?.absoluteString == "https://ssi-mediator-20.esatus.com/basic-routing/v1/create-inbox")
        XCTAssertTrue(sut.httpMethod == "POST")

        let expectedJson = try! CreateInboxMessage(data: sut.httpBody!).jsonString()

        XCTAssertTrue(expectedJson == TestData.createInboxJson)
    }

    func test_add_route_request() {
        let expectedDestination = "string"
        let expectedId = "3fa85f64-5717-4562-b3fc-2c963f66afa6"
        let sut = MediatorRouter.addRoute(id: expectedId, destination: expectedDestination).urlRequest()

        XCTAssertTrue(sut.allHTTPHeaderFields?.contains(where: { $0.key == "IsAddRouting" && $0.value == "True" }) ?? false)
        XCTAssertTrue(sut.url?.absoluteString == "https://ssi-mediator-20.esatus.com/basic-routing/v1/add-route")
        XCTAssertTrue(sut.httpMethod == "POST")

        let expectedJson = try! AddRouteMessage(data: sut.httpBody!).jsonString()

        XCTAssertTrue(expectedJson == TestData.addRoutejson)
    }

    func test_get_inbox_items_request() {
        let expectedId = "3fa85f64-5717-4562-b3fc-2c963f66afa6"
        let sut = MediatorRouter.getInboxItems(id: expectedId).urlRequest()

        XCTAssertTrue(sut.allHTTPHeaderFields?.contains(where: { $0.key == "IsGetInboxItems" && $0.value == "True" }) ?? false)
        XCTAssertTrue(sut.url?.absoluteString == "https://ssi-mediator-20.esatus.com/basic-routing/v1/get-inbox-items")
        XCTAssertTrue(sut.httpMethod == "POST")

        let expectedJson = try! GetInboxItemsMessage(data: sut.httpBody!).jsonString()

        XCTAssertTrue(expectedJson == TestData.getInboxItemsJson)
    }

    func test_delete_inbox_items_request() {
        let expectedId = "3fa85f64-5717-4562-b3fc-2c963f66afa6"
        let expectedItemIds = ["1", "2", "3"]
        let sut = MediatorRouter.deleteInboxItems(id: expectedId, inboxItemIds: expectedItemIds).urlRequest()

        XCTAssertTrue(sut.allHTTPHeaderFields?.contains(where: { $0.key == "IsDeleteInboxItems" && $0.value == "True" }) ?? false)
        XCTAssertTrue(sut.url?.absoluteString == "https://ssi-mediator-20.esatus.com/basic-routing/v1/delete-inbox-items")
        XCTAssertTrue(sut.httpMethod == "POST")

        let expectedJson = try! DeleteInboxItemsMessage(data: sut.httpBody!).jsonString()

        XCTAssertTrue(expectedJson == TestData.deleteInboxItemsJson)
    }

    func test_add_device_info_request() {
        let expectedId = "3fa85f64-5717-4562-b3fc-2c963f66afa6"
        let expectedDeviceId = "deviceId"
        let expectedDeviceMetadata = DeviceMetadata(push: "NotificationHubIDW", createdAt: TimeInterval(1_639_395_437))
        let sut = MediatorRouter.addDeviceInfo(id: expectedId, deviceId: expectedDeviceId, deviceMetadata: expectedDeviceMetadata).urlRequest()

        XCTAssertTrue(sut.allHTTPHeaderFields?.contains(where: { $0.key == "IsDeviceRegistration" && $0.value == "True" }) ?? false)
        XCTAssertTrue(sut.url?.absoluteString == "https://ssi-mediator-20.esatus.com/basic-routing/v1/add-device-info")
        XCTAssertTrue(sut.httpMethod == "POST")

        let expectedJson = try! AddDeviceInfoMessage(data: sut.httpBody!).jsonString()

        XCTAssertTrue(expectedJson == TestData.addDeviceInfoJson)
    }
}

private enum TestData {
    static let createInboxJson =
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

    static let addRoutejson: String = """
    {
      "@id" : "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "@type" : "https://didcomm.org/basic-routing/1.0/add-route",
      "routeDestination" : "string"
    }
    """

    static let getInboxItemsJson: String = """
    {
      "@id" : "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "@type" : "https://didcomm.org/basic-routing/1.0/get-inbox-items"
    }
    """

    static let deleteInboxItemsJson: String = """
    {
      "@id" : "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "@type" : "https://didcomm.org/basic-routing/1.0/delete-inbox-items",
      "inboxItemIds" : [
        "1",
        "2",
        "3"
      ]
    }
    """

    static let addDeviceInfoJson: String = """
    {
      "@id" : "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "@type" : "https://didcomm.org/basic-routing/1.0/add-device-info",
      "deviceId" : "deviceId",
      "deviceMetadata" : {
        "CreatedAt" : 1639395437,
        "Push" : "NotificationHubIDW"
      },
      "deviceVendor" : "iOS"
    }
    """
}
