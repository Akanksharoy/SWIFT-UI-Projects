//
//  Untitled.swift
//  CleanArchitecture
//
//  Created by Akanksha on 25/09/26.
//

final class EmployeeRepositoryImpl:
    EmployeeRepository {

    private let service: EmployeeService

    init(service: EmployeeService) {
        self.service = service
    }

    func getEmployees()
        async throws -> [Employee] {

        let employeeDTOs =
            try await service.fetchEmployees()

        return employeeDTOs.map {
            $0.toDomain()
        }
    }
}
