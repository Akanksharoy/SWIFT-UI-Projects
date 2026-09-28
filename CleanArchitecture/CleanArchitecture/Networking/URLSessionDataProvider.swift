//
//  URLSessionDataProvider.swift
//  CleanArchitecture
//
//  Created by Akanksha on 25/09/26.
//

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
import Foundation
final class URLSessionDataProvider: DataProvider {

    private let session: URLSession
    private let retryCount: Int

    init(
        session: URLSession = .shared,
        retryCount: Int = 3
    ) {
        self.session = session
        self.retryCount = retryCount
    }

    func get(endpoint: Endpoint) async throws -> Data {
        try await executeRequest(
            endpoint: endpoint,
            method: HTTPMethod.get.rawValue
        )
    }

    func post(
        endpoint: Endpoint,
        body: Data
    ) async throws -> Data {
        try await executeRequest(
            endpoint: endpoint,
            method: HTTPMethod.post.rawValue,
            body: body
        )
    }

    func put(
        endpoint: Endpoint,
        body: Data
    ) async throws -> Data {
        try await executeRequest(
            endpoint: endpoint,
            method: HTTPMethod.put.rawValue,
            body: body
        )
    }

    func delete(endpoint: Endpoint) async throws -> Data {
        try await executeRequest(
            endpoint: endpoint,
            method: "DELETE"
        )
    }
}
private extension URLSessionDataProvider {

    private func executeRequest(
        endpoint: Endpoint,
        method: String,
        body: Data? = nil
    ) async throws -> Data {

        var request = URLRequest(url: endpoint.url)

        request.httpMethod = method
        request.httpBody = body

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Accept"
        )

        endpoint.headers.forEach {
            request.setValue(
                $1,
                forHTTPHeaderField: $0
            )
        }

        var lastError: Error?

        for attempt in 0...retryCount {
            do {
                let (data, response) = try await session.data(
                    for: request
                )

                guard let response = response as? HTTPURLResponse else {
                    throw NetworkError.badURLResponse(
                        url: endpoint.url
                    )
                }

                guard 200..<300 ~= response.statusCode else {
                    throw NetworkError.statusCode(
                        response.statusCode
                    )
                }

                return data

            } catch {
                lastError = error

                if attempt < retryCount {
                    continue
                }
            }
        }

        throw lastError ?? NetworkError.unknown(
            NSError(domain: "Network", code: -1)
        )
    }
}
