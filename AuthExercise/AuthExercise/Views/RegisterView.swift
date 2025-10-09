// Issues: Everything inside the view
// Using local @State insetead of biding
// Logic comparing the passwords and calling the register service here

// Improvements: USing RegisterViewModel to manage the variables
// The view only show the fields and call the function register() of the ViewModel
// Using task() to async/await


import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel: RegisterViewModel
    
    @MainActor
    init(viewModel: @MainActor @autoclosure @escaping () -> RegisterViewModel = RegisterViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        VStack {
            Text("Register")
                .font(.largeTitle)
            
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Confirm Password", text: $viewModel.confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Register") {
                Task {
                    await viewModel.register()
                }
            }
            .padding()
        }
        .padding()
    }
}

