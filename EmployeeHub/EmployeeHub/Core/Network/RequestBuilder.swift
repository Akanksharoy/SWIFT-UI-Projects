//
//  RequestBuilder.swift
//  EmployeeHub
//
//  Created by Akanksha on 06/08/26.
//

import Foundation

struct RequestBuilder {

    private let configuration: AppConfiguration

    init(configuration: AppConfiguration) {
        self.configuration = configuration
    }

    func build(from endpoint: Endpoint) throws -> URLRequest {

        guard var components = URLComponents(
            url: configuration.baseURL,
            resolvingAgainstBaseURL: false
        ) else {

            throw NetworkError.invalidURL

        }

        components.path += endpoint.path
        components.queryItems = endpoint.queryItems

        guard let url = components.url else {

            throw NetworkError.invalidURL

        }

        var request = URLRequest(url: url)

        request.httpMethod = endpoint.method.rawValue

        request.httpBody = endpoint.body

        endpoint.headers?.forEach {

            request.addValue(
                $0.value,
                forHTTPHeaderField: $0.key
            )

        }

        return request

    }

}
