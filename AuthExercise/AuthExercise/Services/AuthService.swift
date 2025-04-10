import Foundation

class AuthService {
    static let shared = AuthService()
    
    var users: [String: String] = [:]
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        if let storedPassword = users[email], storedPassword == password {
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func register(email: String, password: String, completion: @escaping (Bool) -> Void) {
        users[email] = password
        completion(true)
    }
}
