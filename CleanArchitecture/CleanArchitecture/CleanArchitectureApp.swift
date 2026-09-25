//
//  CleanArchitectureApp.swift
//  CleanArchitecture
//
//  Created by Akanksha on 25/09/26.
//

import SwiftUI

/*
 EmployeeApp
 │
 ├── Presentation
 │   └── Employee
 │       ├── EmployeeListView.swift
 │       └── EmployeeListViewModel.swift
 │
 ├── Domain
 │   └── Employee
 │       ├── Employee.swift
 │       ├── EmployeeRepository.swift
 │       └── GetEmployeesUseCase.swift
 │
 ├── Data
 │   └── Employee
 │       ├── EmployeeDTO.swift
 │       ├── EmployeeRepositoryImpl.swift
 │       └── EmployeeService.swift
 │
 ├── Networking
 │   ├── DataProvider.swift
 │   ├── URLSessionDataProvider.swift
 │   ├── MockDataProvider.swift
 │   ├── Endpoint.swift
 │   ├── NetworkError.swift
 │   └── BaseService.swift
 │
 ├── Configuration
 │   └── EnvironmentConfiguration.swift
 │
 └── App
 └── AppContainer.swift
 */



@main
struct CleanArchitectureApp: App {
    private let container =
    AppContainer()
    
    var body: some Scene {
        WindowGroup {
            EmployeeListView(
                viewModel:
                    container
                    .employeeListViewModel
            )
        }
    }
}
