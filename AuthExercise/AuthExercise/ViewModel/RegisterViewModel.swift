//
//  RegisterViewMOdel.swift
//  AuthExercise
//
//  Created by Ariel on 09/10/25.
//
// Same thing of LoginViewModel

import Foundation

@MainActor
final class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String = ""
    @Published var registrationSucceeded: Bool = false
    
    private let authService: any AuthServiceProtocol
    
    init(authService: any AuthServiceProtocol = AuthService.shared) {
        self.authService = authService
    }
    
    func register() async {
        guard passwordsMatch() else { return }
        
        errorMessage = ""
        registrationSucceeded = await authService.register(email: email, password: password)
        
        if !registrationSucceeded {
            errorMessage = "Registration failed"
        }
    }
    
    private func passwordsMatch() -> Bool {
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return false
        }
        return true
    }
}
