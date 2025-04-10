import SwiftUI

struct ContentView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var isLoading: Bool = false
    @State var errorMessage: String = ""
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: handleLogin) {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Login")
                    }
                }
                .disabled(isLoading)
                
                Button("Register") {
                    // TODO: Add registration
                }
                .padding()
                
                NavigationLink(
                    destination: DashboardView(),
                    isActive: $isLoggedIn,
                    label: { EmptyView() }
                )
            }
            .padding()
        }
    }
    
    func handleLogin() {
        isLoading = true
        errorMessage = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if self.email == "test@example.com" && self.password == "password123" {
                print("Login success!")
                self.isLoggedIn = true
            } else {
                self.errorMessage = "Invalid credentials"
            }
            self.isLoading = false
        }
    }
}
