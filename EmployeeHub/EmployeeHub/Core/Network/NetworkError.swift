//
//  NetworkError.swift
//  EmployeeHub
//
//  Created by Akanksha on 06/08/26.
//

import Foundation

enum NetworkError: Error {

    case invalidURL

    case invalidResponse

    case decodingError

    case unauthorized

    case serverError(Int)

    case noInternet

    case timeout

    case unknown(Error)

}
