//
//  Employee.swift
//  EmployeeHub
//
//  Created by Akanksha on 06/08/26.
//

import Foundation

struct Employee: Identifiable, Equatable {

    let id: Int
    let fullName: String
    let email: String
    let avatarURL: URL?
    let department: String
}
