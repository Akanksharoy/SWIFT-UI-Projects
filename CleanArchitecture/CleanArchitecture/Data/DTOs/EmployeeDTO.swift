//
//  EmployeeDTO.swift
//  CleanArchitecture
//
//  Created by Akanksha on 25/09/26.

/*
 Why DTO and Entity are different
\*/





struct EmployeeDTO: Decodable {

    let id: Int
    let name: String
    let email: String
    let company: CompanyDTO

    struct CompanyDTO: Decodable {
        let name: String
    }
}
extension EmployeeDTO {

    func toDomain() -> Employee {

        Employee(
            id: id,
            name: name,
            email: email,
            companyName: company.name
        )
    }
}
