import Foundation

protocol AuthServiceProtocol: Sendable {
    func login(email: String, password: String) async -> Bool
    func register(email: String, password: String) async -> Bool
}

actor AuthService: AuthServiceProtocol {
    private let credentialStore: any CredentialStoreProtocol
    
    init(credentialStore: any CredentialStoreProtocol) {
        self.credentialStore = credentialStore
    }
    
    func login(email: String, password: String) async -> Bool {
        do {
            guard let storedPassword = try credentialStore.password(for: email) else {
                return false
            }
            return storedPassword == password
        } catch {
            return false
        }
    }
    
    func register(email: String, password: String) async -> Bool {
        do {
            try credentialStore.storePassword(password, for: email)
            return true
        } catch {
            return false
        }
    }
}
