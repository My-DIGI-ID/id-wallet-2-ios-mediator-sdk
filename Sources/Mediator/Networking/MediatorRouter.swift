//
// Copyright 2022 Bundesrepublik Deutschland
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
// the License. You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//

import DeviceCheck
import Foundation

private enum Constants {
    static let timeoutInterval: Double = 20
}

enum MediatorRouter: MediatorEndpoint {
    case discover

    var method: HttpMethod {
        switch self {
        case .discover:
            return .GET
        }
    }

    var basePath: String {
        switch self {
        case .discover:
            return "/.well-known"
        }
    }

    var path: String {
        switch self {
        case .discover:
            return "agent-configuration"
        }
    }

    var url: URL {
        switch self {
        case .discover:
            guard let url = URL(string: "\(basePath)/\(path)", relativeTo: Networking.hostURL) else {
                fatalError("That shouldn't happen : Crash at discover URL generation")
            }
            return url
        }
    }

    func urlRequest(cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: Constants.timeoutInterval)
        request.httpMethod = method.rawValue
        encodeHttpBody(request: &request)
        return request
    }

    func encodeHttpBody(request: inout URLRequest) {
        switch self {
        case .discover:
            break
        }
    }
}
