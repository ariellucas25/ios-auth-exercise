import Foundation

// I've migrated this service to a protocol based, implemented swift concurrency with actor and async functions.

protocol EmployeeServiceProtocol: Sendable {
    func fetchEmployees() async -> [Employee]
}

actor EmployeeService: EmployeeServiceProtocol {
    static let shared: EmployeeService = EmployeeService()
    
    func fetchEmployees() async -> [Employee] {
        // Simulate latency to mirror a network call
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        return [
            Employee(
                id: "E001",
                name: "John Smith",
                profilePicture: "person.circle.fill",
                yearsOfExperience: 5,
                bio: "John is a senior developer with expertise in iOS and Swift. He enjoys building beautiful user interfaces and optimizing performance.",
                department: "Engineering"
            ),
            Employee(
                id: "E002",
                name: "Sarah Johnson",
                profilePicture: "person.circle.fill",
                yearsOfExperience: 7,
                bio: "Sarah leads the design team with her innovative approach to UI/UX. She has a passion for creating intuitive user experiences.",
                department: "Design"
            ),
            Employee(
                id: "E003",
                name: "Michael Chen",
                profilePicture: "person.circle.fill",
                yearsOfExperience: 3,
                bio: "Michael is a product manager with a background in market research. He excels at understanding user needs and planning product roadmaps.",
                department: "Product"
            ),
            Employee(
                id: "E004",
                name: "Emily Davis",
                profilePicture: "person.circle.fill",
                yearsOfExperience: 4,
                bio: "Emily brings strong analytical skills to the data science team. She specializes in machine learning and predictive analytics.",
                department: "Data Science"
            ),
            Employee(
                id: "E005",
                name: "David Wilson",
                profilePicture: "person.circle.fill",
                yearsOfExperience: 6,
                bio: "David is a security expert focused on building robust infrastructure. He has led multiple security audits and implementation projects.",
                department: "Infrastructure"
            )
        ]
    }
}
