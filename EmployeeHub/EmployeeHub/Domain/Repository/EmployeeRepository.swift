//
//  EmployeeRepository.swift
//  EmployeeHub
//
//  Created by Akanksha on 06/08/26.
//

import Foundation
import Combine

protocol EmployeeRepository {

    func fetchEmployees() -> AnyPublisher<[Employee], Never>

}
