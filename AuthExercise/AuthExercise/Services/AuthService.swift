import Foundation

// I've changed this service to define protocol and enable dependency injection

protocol AuthServiceProtocol: Sendable {
    func login(email: String, password: String) async -> Bool
    func register(email: String, password: String) async -> Bool
}

actor AuthService: AuthServiceProtocol {
    static let shared: AuthService = AuthService()
    
    // Removed the reponsability of saving data of the View
    private var users: [String: String] = [
        "test@example.com": "password123"
    ]
    
    func login(email: String, password: String) async -> Bool {
        users[email] == password
    }
    
    func register(email: String, password: String) async -> Bool {
        users[email] = password
        return true
    }
}
