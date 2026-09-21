//
//  AppContainer.swift
//  EmployeeHub
//
//  Created by Akanksha on 06/08/26.
//

import Foundation

final class AppContainer {

    static let shared = AppContainer()

    private init() { }

    lazy var employeeService: EmployeeService = {

        EmployeeAPIService()

    }()

    lazy var employeeRepository: EmployeeRepository = {

        EmployeeRepositoryImpl(
            service: employeeService
        )

    }()

    func makeEmployeeListViewModel() -> EmployeeListViewModel {

        EmployeeListViewModel(
            repository: employeeRepository
        )

    }

}
