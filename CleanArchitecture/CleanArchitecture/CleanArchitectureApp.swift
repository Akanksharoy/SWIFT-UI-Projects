//
//  CleanArchitectureApp.swift
//  CleanArchitecture
//
//  Created by Akanksha on 25/09/26.
//

import SwiftUI

/*
 EmployeeDirectory
     ├── Presentation
     │   ├── EmployeeListView.swift
     │   └── EmployeeListViewModel.swift
     │
     ├── Domain
     │   ├── Entities
     │   │   └── Employee.swift
     │   │
     │   ├── Repositories
     │   │   └── EmployeeRepository.swift
     │   │
     │   └── UseCases
     │       └── GetEmployeesUseCase.swift
     │
     ├── Data
     │   ├── DTOs
     │   │   └── EmployeeDTO.swift
     │   │
     │   ├── Repositories
     │   │   └── EmployeeRepositoryImpl.swift
     │   │
     │   └── Services
     │       ├── APIClient.swift
     │       └── EmployeeAPI.swift
     │
     └── App
         └── EmployeeDirectoryApp.swift
 */



@main
struct CleanArchitectureApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
