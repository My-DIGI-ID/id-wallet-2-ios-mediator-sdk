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

import Foundation

final class Networking {

    enum Version: String {
        case v1
    }
    
    static var hostURL: URL = .init(string: "https://mediator.dev.essid-demo.com")!

    static var sessionConfiguration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = [
            "Content-Type": "application/ssi-agent-wire"
        ]
        configuration.waitsForConnectivity = true
        configuration.allowsCellularAccess = true
        configuration.multipathServiceType = .interactive
        configuration.requestCachePolicy = .useProtocolCachePolicy
        configuration.httpShouldUsePipelining = true
        configuration.tlsMinimumSupportedProtocolVersion = .TLSv12
        return configuration
    }()

    /// Default session
    lazy var session: URLSession = {
        let session = URLSession(configuration: Networking.sessionConfiguration)
        return session
    }()
}
