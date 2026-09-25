//
//  EmployeeRepository.swift
//  CleanArchitecture
//
//  Created by Akanksha on 25/09/26.
//

protocol EmployeeRepository {

    func getEmployees() async throws -> [Employee]
}
