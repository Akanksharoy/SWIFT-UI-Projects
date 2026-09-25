//
//  EmployeeListViewModel.swift
//  CleanArchitecture
//
//  Created by Akanksha on 25/09/26.
//

import SwiftUI

@MainActor
@Observable
final class EmployeeListViewModel {

    private let getEmployeesUseCase:
        GetEmployeesUseCase

    var employees: [Employee] = []

    var isLoading = false

    var errorMessage: String?

    init(
        getEmployeesUseCase:
            GetEmployeesUseCase
    ) {
        self.getEmployeesUseCase =
            getEmployeesUseCase
    }

    func loadEmployees() async {

        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {

            employees =
                try await getEmployeesUseCase.execute()

        } catch {

            errorMessage =
                error.localizedDescription
        }
    }
}
