//
//  EnvironmentConfiguration.swift
//  CleanArchitecture
//
//  Created by Akanksha on 25/09/26.
//
import Foundation
struct EnvironmentConfiguration {

    let baseURL: URL
    let defaultHeaders: [String: String]

    init(
        baseURL: URL,
        defaultHeaders: [String: String] = [:]
    ) {
        self.baseURL = baseURL
        self.defaultHeaders = defaultHeaders
    }

    static func production()
        -> EnvironmentConfiguration {

        EnvironmentConfiguration(
            baseURL: URL(
                string:
                    "https://jsonplaceholder.typicode.com"
            )!,
            defaultHeaders: [:]
        )
    }
}
