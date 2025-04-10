import SwiftUI

struct DashboardView: View {
    @State private var employees: [Employee] = []
    @State private var isLoading: Bool = true
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Dashboard")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Welcome! You are now logged in.")
                .font(.headline)
            
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
                    
                    if isLoading {
                        ProgressView()
                    }
                }
                
                if employees.isEmpty && !isLoading {
                    Text("No employees found")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(employees) { employee in
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
        .onAppear {
            fetchEmployees()
        }
    }
    
    private func fetchEmployees() {
        isLoading = true
        EmployeeService.fetchEmployees { fetchedEmployees in
            self.employees = fetchedEmployees
            self.isLoading = false
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
        DashboardView()
    }
} 