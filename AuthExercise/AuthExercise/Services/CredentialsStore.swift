//
//  CredentialsStore.swift
//  AuthExercise
//
//  Created by Ariel on 09/10/25.
//
// I've implemented the KeyChain Store to improve the security and allows user registration.


import Foundation
import Security

// Handles Keychain storage for email/password pairs
final class CredentialStore {
    static let shared = CredentialStore(service: "com.ariel.AuthExercise")
    private let service: String

    init(service: String) { self.service = service }

    func storePassword(_ password: String, for email: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: email,
            kSecValueData as String: Data(password.utf8),
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecDuplicateItem {
            try updatePassword(password, for: email)
        } else if status != errSecSuccess {
            throw KeychainError.unhandled(status)
        }
    }

    func password(for email: String) throws -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: email,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else { return nil }
        guard status == errSecSuccess,
              let data = item as? Data,
              let password = String(data: data, encoding: .utf8) else {
            throw KeychainError.unhandled(status)
        }
        return password
    }

    private func updatePassword(_ password: String, for email: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: email
        ]
        let attributes: [String: Any] = [
            kSecValueData as String: Data(password.utf8)
        ]
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status == errSecSuccess else { throw KeychainError.unhandled(status) }
    }

    enum KeychainError: Error {
        case unhandled(OSStatus)
    }
}
