//
//  LoginViewModel.swift
//  AuthExercise
//
//  Created by Ariel on 09/10/25.
//
// I've created this ViewModel to remove the data logic and service calls from the View LoginView
// I'm using @Published and the AuthService protocol

import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    
    private let authService: any AuthServiceProtocol
    private let sessionStore: SessionStore
    
    init(
        authService: any AuthServiceProtocol = AuthService.shared,
        sessionStore: SessionStore
    ) {
        self.authService = authService
        self.sessionStore = sessionStore
    }
    
    func login() async {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = ""
        
        defer { isLoading = false }
        
        guard await authService.login(email: email, password: password) else {
            errorMessage = "Invalid credentials"
            return
        }
        
        // setting user information 
        sessionStore.setAuthenticated(email: email)
    }
}
