//
//  EmployeeListViewModel.swift
//  EmployeeHub
//
//  Created by Akanksha on 05/08/26.
//

import Combine

import Foundation
import Combine

final class EmployeeListViewModel: ObservableObject {

    @Published
    private(set) var employees: [Employee] = []

    private let repository: EmployeeRepository

    private var cancellables = Set<AnyCancellable>()

    init(repository: EmployeeRepository) {

        self.repository = repository

    }

    func loadEmployees() {

        repository
            .fetchEmployees()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] employees in

                self?.employees = employees

            }
            .store(in: &cancellables)

    }

}
