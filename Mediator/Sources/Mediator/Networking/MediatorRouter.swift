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

import Foundation

enum MediatorRouter: Endpoint {
    case discover
    case createInbox
    case addRoute
    case getInboxItems
    case deleteInboxItems
    case addDeviceInfo

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
}
