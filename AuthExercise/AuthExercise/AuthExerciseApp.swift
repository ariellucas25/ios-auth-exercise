//
//  AuthExerciseApp.swift
//  AuthExercise
//
//  Created by Sebastian Grobelny on 4/10/25.
//

// Changes: Creating an @StateObject to sessionStore and injecting it to the ContentView().

import SwiftUI

@main
struct AuthExerciseApp: App {
    @StateObject private var sessionStore = SessionStore()
    private let authService: any AuthServiceProtocol
    private let employeeService: any EmployeeServiceProtocol
    
    init() {
        let credentialStore = CredentialStore()
        self.authService = AuthService(credentialStore: credentialStore)
        self.employeeService = EmployeeService()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                sessionStore: sessionStore,
                authService: authService,
                employeeService: employeeService
            )
        }
    }
}
