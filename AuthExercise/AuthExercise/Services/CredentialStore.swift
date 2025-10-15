import Foundation
import Security

protocol CredentialStoreProtocol: Sendable {
    func storePassword(_ password: String, for email: String) throws
    func password(for email: String) throws -> String?
}

// Handles Keychain storage for email/password pairs
// final because it cannot be subclassed
final class CredentialStore: CredentialStoreProtocol {
    private let service: String
    
    // defining the service identifier
    init(service: String = "com.ariel.AuthExercise") {
        self.service = service
    }
    
    // _ means that the external argument is omitted
    func storePassword(_ password: String, for email: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword, // setting that the item is a password
            kSecAttrService as String: service,
            kSecAttrAccount as String: email,
            kSecValueData as String: Data(password.utf8),
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked // only available when the app is unlocked
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
