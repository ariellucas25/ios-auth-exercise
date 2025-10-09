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
    
    var body: some Scene {
        WindowGroup {
            ContentView(sessionStore: sessionStore)
        }
    }
}
