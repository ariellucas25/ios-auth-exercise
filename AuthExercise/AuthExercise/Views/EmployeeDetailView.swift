// Not changed 

import SwiftUI

struct EmployeeDetailView: View {
    let employee: Employee
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header with profile image and name
                HStack {
                    Image(systemName: employee.profilePicture)
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                        .frame(width: 100, height: 100)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(employee.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(employee.department)
                            .font(.title3)
                            .foregroundColor(.secondary)
                        
                        Text("\(employee.yearsOfExperience) years of experience")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.bottom, 10)
                
                // Bio section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Biography")
                        .font(.headline)
                    
                    Text(employee.bio)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineSpacing(5)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Contact Info (mock data)
                VStack(alignment: .leading, spacing: 10) {
                    Text("Contact Information")
                        .font(.headline)
                    
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.blue)
                        Text("\(employee.name.lowercased().replacingOccurrences(of: " ", with: "."))@company.com")
                    }
                    
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.blue)
                        Text("(555) 123-4567")
                    }
                    
                    HStack {
                        Image(systemName: "location.fill")
                            .foregroundColor(.blue)
                        Text("Main Office, Floor \(Int.random(in: 1...5))")
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Employee Details", displayMode: .inline)
    }
}

#Preview {
    NavigationView {
        EmployeeDetailView(employee: Employee(
            id: "E001",
            name: "John Smith",
            profilePicture: "person.circle.fill",
            yearsOfExperience: 5,
            bio: "John is a senior developer with expertise in iOS and Swift. He enjoys building beautiful user interfaces and optimizing performance.",
            department: "Engineering"
        ))
    }
} 
