// Plan: Remove the local @state's to use the @Published vars
// Remove Logic (handleLogin) from the View
// Change the navigation logic responsability to consider the SessionStore instead of controls it locally

import SwiftUI

@MainActor
struct ContentView: View {
    @ObservedObject private var sessionStore: SessionStore
    @StateObject private var viewModel: LoginViewModel
    
    init(sessionStore: SessionStore) {
        self.sessionStore = sessionStore
        _viewModel = StateObject(wrappedValue: LoginViewModel(sessionStore: sessionStore))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                }
                
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: login) {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text("Login")
                    }
                }
                .disabled(viewModel.isLoading)
                
                Button("Register") {
                    // TODO: Add registration
                }
                .padding()
            }
            .navigationDestination(isPresented: Binding(
                get: { sessionStore.isAuthenticated },
                set: { sessionStore.isAuthenticated = $0 }
            )) {
                DashboardView()
            }
            .padding()
        }
    }
    
    private func login() {
        Task {
            await viewModel.login()
        }
    }
}
