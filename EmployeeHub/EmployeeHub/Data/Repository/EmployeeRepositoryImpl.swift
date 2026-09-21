//
//  EmployeeRepositoryImpl.swift
//  EmployeeHub
//
//  Created by Akanksha on 06/08/26.
//


import Foundation
import Combine

import Foundation
import Combine

final class EmployeeRepositoryImpl: EmployeeRepository {

    private let service: EmployeeService

    init(service: EmployeeService) {

        self.service = service

    }
    func fetchEmployees() -> AnyPublisher<[Employee], Never> {
        service.fetchEmployees()

    }
}
