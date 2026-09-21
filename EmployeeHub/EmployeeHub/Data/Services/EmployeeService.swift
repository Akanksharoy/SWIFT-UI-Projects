//
//  EmployeeService.swift
//  EmployeeHub
//
//  Created by Akanksha on 06/08/26.
//

import Foundation
import Combine

protocol EmployeeService {

    func fetchEmployees() -> AnyPublisher<[Employee], Never>

}
final class EmployeeAPIService: EmployeeService {

    func fetchEmployees() -> AnyPublisher<[Employee], Never> {

        let employees = [

            Employee(
                id: 1,
                fullName: "John Doe",
                email: "john@company.com",
                avatarURL: nil,
                department: "Engineering"
            ),

            Employee(
                id: 2,
                fullName: "Alice Smith",
                email: "alice@company.com",
                avatarURL: nil,
                department: "Design"
            ),

            Employee(
                id: 3,
                fullName: "Robert Brown",
                email: "robert@company.com",
                avatarURL: nil,
                department: "HR"
            )

        ]

        return Just(employees)
            .eraseToAnyPublisher()

    }

}
