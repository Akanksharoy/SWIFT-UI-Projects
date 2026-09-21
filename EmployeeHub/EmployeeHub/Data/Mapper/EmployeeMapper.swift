//
//  EmployeeMapper.swift
//  EmployeeHub
//
//  Created by Akanksha on 06/08/26.
//

import Foundation

enum EmployeeMapper {

    static func map(_ dto: EmployeeDTO) -> Employee {

        Employee(
            id: dto.id,
            fullName: "\(dto.firstName) \(dto.lastName)",
            email: dto.email,
            avatarURL: dto.avatar.flatMap(URL.init(string:)),
            department: dto.department
        )
    }
}
