//
//  KeychainHelper.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 25/09/24.
//


import Security
import Foundation

class KeychainHelper {
    static func saveKey(key: Data) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "realmEncryptionKey",
            kSecValueData as String: key
        ]

        SecItemDelete(query as CFDictionary) // Delete any existing key
        SecItemAdd(query as CFDictionary, nil) // Add the new key
    }

    static func loadKey() -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "realmEncryptionKey",
            kSecReturnData as String: kCFBooleanTrue as Any,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess else {
            return nil
        }

        return item as? Data
    }

    static func generateKey() -> Data {
        var key = Data(count: 64)
        let result = key.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, 64, $0.baseAddress!)
        }

        if result != errSecSuccess {
            fatalError("Unable to generate random bytes")
        }
        
        return key
    }
}
