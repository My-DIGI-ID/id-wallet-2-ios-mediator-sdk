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

public protocol Discoverable {
    func discover() async throws -> AgentConfiguration
}

extension MediatorService: Discoverable {
    /// Performs an async network discover request retrieving the mediator information
    /// - Returns: AgentConfiguration
    public func discover() async throws -> AgentConfiguration {
        let (data, _) = try await networking.session.data(for: MediatorRouter.discover.request)
        let decoded = try JSONDecoder.decoder().decode(AgentConfiguration.self, from: data)
        return decoded
    }
}
