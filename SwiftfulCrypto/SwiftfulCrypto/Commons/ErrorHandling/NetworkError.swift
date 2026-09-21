//
//  APIError.swift
//  SwiftfulCrypto
//
//  Created by Akanksha on 27/08/26.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidRequest
    case noData
    case decodingFailed
    case badURLResponse(url:URL)
    case unknown(Error)


    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid."

        case .invalidRequest:
            return "Invalid Request."

        case .noData:
            return "No data received."

        case .decodingFailed:
            return "Failed to decode the server response."
            
        case .badURLResponse(let url):
            return "The URL \(url) is not valid."

        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
