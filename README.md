# iOS Authentication Exercise
Created: 2025-04-10 23:16:58
Author: grobestr

## Overview
This is a basic iOS authentication implementation that needs improvement. The app provides simple login/register functionality but contains several architectural and security flaws that need to be addressed.

## Setup
1. Clone this repository
2. Open AuthExercise.xcodeproj in Xcode
3. Build and run

## Test Credentials
- Email: test@example.com  
- Password: password123

## Assignment Details
Time: 60 minutes

### Current Features
- Basic login screen
- User registration
- In-memory user storage
- Basic error handling

### Your Task
Review and improve the codebase focusing on:

1. Security
   - Review how credentials are handled
   - Identify security vulnerabilities
   - Suggest/implement better security practices

2. Architecture
   - Evaluate current architecture
   - Identify architectural issues
   - Propose improvements

3. Code Quality
   - Review error handling
   - Check state management
   - Assess current patterns used

### Instructions
1. Take 10-15 minutes to review the code
2. Identify key areas that need improvement
3. Plan your approach
4. Make improvements in order of priority
5. Document what else you would change given more time

### Notes
- You don't need to implement everything
- Focus on demonstrating your knowledge of iOS best practices
- Comment your changes to explain your thinking
- Quality > Quantity

### Evaluation Criteria
- Understanding of iOS/Swift best practices
- Security awareness
- Code organization and architecture
- Quality of improvements made
- Explanation of further improvements needed

## Project Structure

```
AuthExercise/
├── README.md
└── AuthExercise/
    ├── AuthExercise.xcodeproj/
    ├── AuthExercise/
    │   ├── Assets.xcassets/
    │   ├── AuthExerciseApp.swift
    │   ├── AuthExercise.entitlements
    │   ├── Preview Content/
    │   ├── Models/
    │   │   ├── Employee.swift
    │   │   └── User.swift
    │   ├── Views/
    │   │   ├── ContentView.swift
    │   │   ├── DashboardView.swift
    │   │   ├── EmployeeDetailView.swift
    │   │   └── RegisterView.swift
    │   └── Services/
    │       ├── AuthService.swift
    │       └── EmployeeService.swift
    ├── AuthExerciseTests/
    └── AuthExerciseUITests/
```

## Features

- User authentication with email and password
- Dashboard view with quick action cards
- Employee list with mock API integration
- Employee details view with contact information
- Navigation between views

## Models

### Employee
- id: String
- name: String
- profilePicture: String
- yearsOfExperience: Int
- bio: String
- department: String

## Services

### EmployeeService
- fetchEmployees: Simulates API call to retrieve employee data

### AuthService
- Handles user authentication

## Next Steps
1. Review the code
2. Plan your improvements
3. Implement highest priority changes
4. Document additional improvements you'd make with more time

Remember: The goal is to demonstrate your understanding of iOS development best practices and your ability to identify and improve code quality.