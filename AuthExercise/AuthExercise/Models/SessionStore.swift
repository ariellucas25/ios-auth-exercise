//
//  SessionStore.swift
//  AuthExercise
//
//  Created by Ariel on 09/10/25.
//
// I've created this Model to centralize the Authentication State in all App

import Foundation
import SwiftUI

@MainActor
final class SessionStore: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var currentUserEmail: String?
    
    func setAuthenticated(email: String) {
        currentUserEmail = email
        isAuthenticated = true
    }
    
    func resetSession() {
        currentUserEmail = nil
        isAuthenticated = false
    }
}
