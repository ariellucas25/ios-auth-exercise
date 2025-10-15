// Plan: Remove the local @state's to use the @Published vars
// Remove Logic (handleLogin) from the View
// Change the navigation logic responsability to consider the SessionStore instead of controls it locally

import SwiftUI

@MainActor
struct ContentView: View {
    // Using ObservedObject because this object is created outside the view and its lifecycle is not controlled by the view.
    @ObservedObject private var sessionStore: SessionStore
    private let authService: any AuthServiceProtocol
    private let employeeService: any EmployeeServiceProtocol
    // @StateObject indicates that this object is created here and will exists only while this view exists
    @StateObject private var viewModel: LoginViewModel
    
    init(
        sessionStore: SessionStore,
        authService: any AuthServiceProtocol,
        employeeService: any EmployeeServiceProtocol
    ) {
        self.sessionStore = sessionStore
        self.authService = authService
        self.employeeService = employeeService
        _viewModel = StateObject(
            wrappedValue: LoginViewModel(
                authService: authService,
                sessionStore: sessionStore
            )
        )
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
                    Task {
                        await viewModel.register()
                    }
                }
                .padding()
            }
            .navigationDestination(isPresented: Binding(
                get: { sessionStore.isAuthenticated },
                set: { sessionStore.isAuthenticated = $0 } // same as writing value in sessionStore.isAuthenticated = value
            )) {
                // Injecting sessionStore to have the logged email on the View
                DashboardView(
                    sessionStore: sessionStore,
                    viewModel: DashboardViewModel(employeeService: employeeService)
                )
            }
            .padding()
        }
    }
    
    private func login() {
        // wrapping the login() func in a Task {}, that creates a new asyncronous task. It's needed because buttons actions are syncronous by default
        Task {
            await viewModel.login()
        }
    }
}
