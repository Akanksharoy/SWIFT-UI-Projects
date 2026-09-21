//
//  EmployeeDTO.swift
//  EmployeeHub
//
//  Created by Akanksha on 06/08/26.
//

import Foundation

struct EmployeeDTO: Codable {

    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let avatar: String?
    let department: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case avatar
        case department
    }
}

