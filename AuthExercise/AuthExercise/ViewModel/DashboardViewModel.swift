//
//  DashboardViewModel.swift
//  AuthExercise
//
//  Created by Ariel on 09/10/25.
//
// I've created this ViewModel to remove the data logic and service calls from the View DashboardView
// I'm using @Published vars to provide data to the view and implementing protocosl to the EmployeeService to enable testing and mock data

import Foundation

@MainActor
final class DashboardViewModel: ObservableObject {
    @Published var employees: [Employee] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    
    private let employeeService: any EmployeeServiceProtocol
    
    // initiating our employeeService 
    init(employeeService: any EmployeeServiceProtocol = EmployeeService.shared) {
        self.employeeService = employeeService
    }
    
    func loadEmployees() async {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = ""
        
        defer { isLoading = false }
        
        employees = await employeeService.fetchEmployees()
        
        if employees.isEmpty {
            errorMessage = "No employees found"
        }
    }
}
