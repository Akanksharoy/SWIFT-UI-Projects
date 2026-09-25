//
//  GetEmployeesUseCase.swift
//  CleanArchitecture
//
//  Created by Akanksha on 25/09/26.
//

protocol GetEmployeesUseCase {

    func execute() async throws -> [Employee]
}


final class GetEmployeesUseCaseImpl: GetEmployeesUseCase {

    private let repository: EmployeeRepository

    init(repository: EmployeeRepository) {
        self.repository = repository
    }

    func execute() async throws -> [Employee] {
        return try await repository.getEmployees()
    }
}
