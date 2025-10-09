// issues:
// Everything is inside the view
// Controlling state locally (only acessible by the View with @State) and calling the FetchEmployees() in the onAppear(), instead of using dependency injection.
// Plan: Use binding to the DashboardViewModel
// Remove Logic that should't be here
// Removed the title "Dashboard" and inserted a new Text to show the logged user email

import SwiftUI

@MainActor
struct DashboardView: View {
    @StateObject private var viewModel: DashboardViewModel
    @ObservedObject private var sessionStore: SessionStore
    
    @MainActor
    init(sessionStore: SessionStore, viewModel: DashboardViewModel? = nil) {
        _viewModel = StateObject(wrappedValue: viewModel ?? DashboardViewModel())
        _sessionStore = ObservedObject(wrappedValue: sessionStore)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome! You are now logged in.")
                .font(.headline)
            
            Text(sessionStore.currentUserEmail ?? "No user email available")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
            
            // Quick Actions section
            VStack(alignment: .leading, spacing: 15) {
                Text("Quick Actions")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                HStack(spacing: 20) {
                    dashboardCard(icon: "person.fill", title: "Profile")
                    dashboardCard(icon: "gear", title: "Settings")
                    dashboardCard(icon: "bell.fill", title: "Notifications")
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            
            // Employees Section
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Employees")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    if viewModel.isLoading {
                        ProgressView()
                    }
                }
                
                if viewModel.employees.isEmpty && !viewModel.isLoading {
                    Text("No employees found")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(viewModel.employees) { employee in
                        NavigationLink(destination: EmployeeDetailView(employee: employee)) {
                            EmployeeRow(employee: employee)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .frame(height: 300)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Dashboard", displayMode: .inline)
        .task {
            await viewModel.loadEmployees()
        }
    }
    
    private func dashboardCard(icon: String, title: String) -> some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(.blue)
                .padding(.bottom, 5)
            
            Text(title)
                .font(.callout)
                .fontWeight(.medium)
        }
        .frame(width: 90, height: 90)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
    }
}

struct EmployeeRow: View {
    let employee: Employee
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: employee.profilePicture)
                .font(.system(size: 40))
                .foregroundColor(.blue)
                .frame(width: 50, height: 50)
                .background(Color.white)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(employee.name)
                    .font(.headline)
                
                HStack {
                    Text(employee.department)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("•")
                    
                    Text("\(employee.yearsOfExperience) years")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    NavigationView {
        DashboardView(sessionStore: SessionStore())
    }
}
