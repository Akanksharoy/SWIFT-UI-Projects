//
//  EnployeeService.swift
//  CleanArchitecture
//
//  Created by Akanksha on 25/09/26.
//
import Foundation


protocol EmployeeService {

    func fetchEmployees()
        async throws -> [EmployeeDTO]
}

final class EmployeeServiceImpl:
    BaseService,
    EmployeeService {

    func fetchEmployees()
        async throws -> [EmployeeDTO] {

        let endpoint =
            Endpoint.employees(
                baseURL:
                    environmentConfiguration.baseURL
            )

        let data =
            try await dataProvider.get(
                endpoint: endpoint
            )

        do {

            return try JSONDecoder().decode(
                [EmployeeDTO].self,
                from: data
            )

        } catch {

            throw NetworkError.decodingError(
                error
            )
        }
    }
}
