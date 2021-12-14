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

private enum Constants {
    static let timeoutInterval: Double = 20
}

enum HttpMethod: String, CaseIterable {
    case GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS
}

protocol Endpoint {
    var method: HttpMethod { get }
    var url: URL { get }
    var request: URLRequest { get }

    func urlRequest(cachePolicy: URLRequest.CachePolicy) throws -> URLRequest
    func encodeHttpBody(request: inout URLRequest)
}

extension Endpoint {
    func urlRequest(cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: Constants.timeoutInterval)
        request.httpMethod = method.rawValue
        encodeHttpBody(request: &request)
        return request
    }

    var request: URLRequest {
        var _request = URLRequest(url: url)
        _request.httpMethod = method.rawValue
        return _request
    }

    public func encodeHttpBody(request _: inout URLRequest) {}
}
