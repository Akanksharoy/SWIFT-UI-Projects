//
//  URLSessionDataProvider.swift
//  CleanArchitecture
//
//  Created by Akanksha on 25/09/26.
//
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

    func get(
        endpoint: Endpoint
    ) async throws -> Data {

        try await performRequest(
            endpoint: endpoint,
            method: "GET",
            body: nil
        )
    }

    func post(
        endpoint: Endpoint,
        body: Data
    ) async throws -> Data {

        try await performRequest(
            endpoint: endpoint,
            method: "POST",
            body: body
        )
    }

    func put(
        endpoint: Endpoint,
        body: Data
    ) async throws -> Data {

        try await performRequest(
            endpoint: endpoint,
            method: "PUT",
            body: body
        )
    }

    func delete(
        endpoint: Endpoint
    ) async throws -> Data {

        try await performRequest(
            endpoint: endpoint,
            method: "DELETE",
            body: nil
        )
    }
}
private extension URLSessionDataProvider {

    func performRequest(
        endpoint: Endpoint,
        method: String,
        body: Data?
    ) async throws -> Data {

        var request = URLRequest(
            url: endpoint.url
        )

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

                let (data, response) =
                    try await session.data(
                        for: request
                    )

                guard let httpResponse =
                        response as? HTTPURLResponse
                else {
                    throw NetworkError.badURLResponse(
                        url: endpoint.url
                    )
                }

                guard 200..<300 ~= httpResponse.statusCode
                else {
                    throw NetworkError.statusCode(
                        httpResponse.statusCode
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
