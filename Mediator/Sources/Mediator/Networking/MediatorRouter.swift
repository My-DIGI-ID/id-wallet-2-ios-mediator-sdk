/*
 * Copyright 2021 Bundesrepublik Deutschland
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
 * an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 */

import DeviceCheck
import Foundation

enum MediatorRouter: Endpoint {
    case discover
    case createInbox(id: String, metadata: Metadata)
    case addRoute(id: String, destination: String)
    case getInboxItems(id: String)
    case deleteInboxItems(id: String, inboxItemIds: [String])
    case addDeviceInfo(id: String, deviceId: String, deviceMetadata: DeviceMetadata)

    var messageType: String {
        switch self {
        case .discover:
            return ""
        case .createInbox:
            return "https://didcomm.org/basic-routing/1.0/create-inbox"
        case .addRoute:
            return "https://didcomm.org/basic-routing/1.0/add-route"
        case .getInboxItems:
            return "https://didcomm.org/basic-routing/1.0/get-inbox-items"
        case .deleteInboxItems:
            return "https://didcomm.org/basic-routing/1.0/delete-inbox-items"
        case .addDeviceInfo:
            return "https://didcomm.org/basic-routing/1.0/add-device-info"
        }
    }

    var method: HttpMethod {
        switch self {
        case .discover:
            return .GET
        default:
            return .POST
        }
    }

    var basePath: String {
        switch self {
        case .discover:
            return "/.well-known"
        default:
            return "/basic-routing"
        }
    }

    var path: String {
        switch self {
        case .discover:
            return "agent-configuration"
        case .createInbox:
            return "create-inbox"
        case .addRoute:
            return "add-route"
        case .getInboxItems:
            return "get-inbox-items"
        case .deleteInboxItems:
            return "delete-inbox-items"
        case .addDeviceInfo:
            return "add-device-info"
        }
    }

    var url: URL {
        switch self {
        case .discover:
            guard let url = URL(string: "\(basePath)/\(path)", relativeTo: Networking.hostURL) else {
                fatalError("That shouldn't happen : Crash at discover URL generation")
            }
            return url
        default:
            return URL(string: "\(basePath)/\(Networking.Version.v1)/\(path)", relativeTo: Networking.hostURL)!
        }
    }

    func encodeHttpBody(request: inout URLRequest) {
        switch self {
        case .discover:
            break
        case let .createInbox(id, metadata):
            request.addValue("True", forHTTPHeaderField: "IsInboxCreation")
            guard let data = try? CreateInboxMessage(id: id,
                                                     type: messageType,
                                                     metadata: metadata).jsonData()
            else {
                return
            }
            request.httpBody = data
        case let .addRoute(id, destination):
            request.addValue("True", forHTTPHeaderField: "IsAddRouting")
            guard let data = try? AddRouteMessage(id: id,
                                                  type: messageType,
                                                  routeDestination: destination).jsonData()
            else {
                return
            }
            request.httpBody = data
        case let .getInboxItems(id):
            request.addValue("True", forHTTPHeaderField: "IsGetInboxItems")
            guard let data = try? GetInboxItemsMessage(id: id,
                                                       type: messageType).jsonData()
            else {
                return
            }
            request.httpBody = data
        case let .deleteInboxItems(id, inboxItemIds):
            request.addValue("True", forHTTPHeaderField: "IsDeleteInboxItems")
            guard let data = try? DeleteInboxItemsMessage(id: id, type: messageType, inboxItemIds: inboxItemIds).jsonData() else {
                return
            }
            request.httpBody = data
        case let .addDeviceInfo(id, deviceId, deviceMetadata):
            request.addValue("True", forHTTPHeaderField: "IsDeviceRegistration")
            guard let data = try? AddDeviceInfoMessage(id: id, type: messageType, deviceId: deviceId, deviceVendor: "iOS", deviceMetadata: deviceMetadata).jsonData() else {
                return
            }
            request.httpBody = data
        }
    }
}
