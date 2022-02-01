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

import CryptoKit
import DeviceCheck
import Foundation
import Valet

private enum Constants {
    static let appAttestKeyId = "appAttestKeyId"
    static let valetIdentifier = Identifier(nonEmpty: "IDWalletAppAuthenticity")!
}

protocol IDWalletSecure {
    func getAttestionObject(challenge: Data) async throws -> String
}

public struct IDWalletSecurity: IDWalletSecure {
    
    private let valet = Valet.valet(with: Constants.valetIdentifier, accessibility: .whenUnlockedThisDeviceOnly)

    /// Retrieves the key identifier for the App Attest service stored in the keychain
    /// If none is found the key identifier is created and stored in the keychain
    /// - Returns: key identifier for the App Attest service
    private func getAppAttestKey() async throws -> String {
        guard let key = try? valet.string(forKey: Constants.appAttestKeyId) else {
            return try await generateAttestKey()
        }
        return key
    }

    /// Generate key identifier for the App Attest service and stores it in the keychain
    /// - Returns: key identifier
    private func generateAttestKey() async throws -> String {
        guard DCAppAttestService.shared.isSupported else {
            throw DCError(.featureUnsupported)
        }
        let key = try await DCAppAttestService.shared.generateKey()
        try valet.setString(key, forKey: Constants.appAttestKeyId)
        return key
    }

    /// Retrieves the attestation object from Apple
    /// - Parameter challenge: the challenge (nonce) from the server
    /// - Returns: An Base64 encoded String of the attestation object
    public func getAttestionObject(challenge: Data) async throws -> String {
        let keyId = try await getAppAttestKey()
        let hash = Data(SHA256.hash(data: challenge))
        let data = try await DCAppAttestService.shared.attestKey(keyId, clientDataHash: hash)
        return data.base64EncodedString()
    }
}
