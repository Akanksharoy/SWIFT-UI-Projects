//
//  AppContainer.swift
//  CleanArchitecture
//
//  Created by Akanksha on 25/09/26.
//


final class AppContainer {

    let employeeListViewModel:
        EmployeeListViewModel

    init() {

        // 1. Configuration

        let configuration =
            EnvironmentConfiguration.production()


        // 2. Networking

        let dataProvider =
            URLSessionDataProvider()


        // 3. Service

        let employeeService =
            EmployeeServiceImpl(
                environmentConfiguration:
                    configuration,
                dataProvider:
                    dataProvider
            )


        // 4. Repository

        let employeeRepository =
            EmployeeRepositoryImpl(
                service:
                    employeeService
            )


        // 5. Use Case

        let getEmployeesUseCase =
            GetEmployeesUseCaseImpl(
                repository:
                    employeeRepository
            )


        // 6. ViewModel

        self.employeeListViewModel =
            EmployeeListViewModel(
                getEmployeesUseCase:
                    getEmployeesUseCase
            )
    }
}
