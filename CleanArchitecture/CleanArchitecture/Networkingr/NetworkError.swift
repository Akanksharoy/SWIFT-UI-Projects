//
//  NetworkError.swift
//  CleanArchitecture
//
//  Created by Akanksha on 25/09/26.
//
import Foundation
enum NetworkError: Error {

    case invalidURL
    case badURLResponse(url: URL)
    case statusCode(Int)
    case decodingError(Error)
    case unknown(Error)
}
