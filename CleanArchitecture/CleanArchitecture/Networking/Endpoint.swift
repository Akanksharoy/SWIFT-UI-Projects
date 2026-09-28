//
//  Endpoint.swift
//  CleanArchitecture
//
//  Created by Akanksha on 25/09/26.
//
import Foundation
struct Endpoint {

    let baseURL: URL
    let path: String
    let queryItems: [URLQueryItem]
    let headers: [String: String]

    var url: URL {

        var components = URLComponents(
            url: baseURL,
            resolvingAgainstBaseURL: true
        )

        components?.path = path

        if !queryItems.isEmpty {
            components?.queryItems = queryItems
        }

        guard let url = components?.url else {
            fatalError("Invalid URL")
        }

        return url
    }

    init(
        baseURL: URL,
        path: String,
        queryItems: [URLQueryItem] = [],
        headers: [String: String] = [:]
    ) {
        self.baseURL = baseURL
        self.path = path
        self.queryItems = queryItems
        self.headers = headers
    }
}
extension Endpoint {

    static func employees(
        baseURL: URL
    ) -> Endpoint {

        Endpoint(
            baseURL: baseURL,
            path: "/employees"
        )
    }
}
