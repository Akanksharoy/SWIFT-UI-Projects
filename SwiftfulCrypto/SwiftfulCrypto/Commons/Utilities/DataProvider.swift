//
//  DataProvide.swift.swift
//  SwiftfulCrypto
//
//  Created by Akanksha on 03/09/26.
//

import Combine
import SwiftUI

// MARK: - DataProvider Protocol

/// Protocol defining the contract for making network requests.
/// This abstraction allows for different implementations (URLSession, mock, etc.).
///
/// Benefits:
/// - Easy to test by injecting MockDataProvider
/// - Can swap implementations without changing service code
/// - Clear contract between services and networking layer
protocol DataProvider {

    /// Performs a GET request and returns a Combine publisher
    func get(endpoint: Endpoint) -> AnyPublisher<Data, Error>

    /// Performs a POST request and returns a Combine publisher
    func post(endpoint: Endpoint, body: Data) -> AnyPublisher<Data, Error>

    /// Performs a PUT request and returns a Combine publisher
    func put(endpoint: Endpoint, body: Data) -> AnyPublisher<Data, Error>

    /// Performs a DELETE request and returns a Combine publisher
    func delete(endpoint: Endpoint) -> AnyPublisher<Data, Error>
}

// MARK: - URLSessionDataProvider

/// Concrete implementation of DataProvider using URLSession.
/// This is the production implementation that makes real network calls.
class URLSessionDataProvider: DataProvider {

    private let session: URLSession
    private let retryCount: Int

    init(
        session: URLSession = .shared,
        retryCount: Int = 3
    ) {
        self.session = session
        self.retryCount = retryCount
    }

    func get(endpoint: Endpoint) -> AnyPublisher<Data, Error> {
        performRequest(
            endpoint: endpoint,
            method: "GET",
            body: nil
        )
    }

    func post(
        endpoint: Endpoint,
        body: Data
    ) -> AnyPublisher<Data, Error> {
        performRequest(
            endpoint: endpoint,
            method: "POST",
            body: body
        )
    }

    func put(
        endpoint: Endpoint,
        body: Data
    ) -> AnyPublisher<Data, Error> {
        performRequest(
            endpoint: endpoint,
            method: "PUT",
            body: body
        )
    }

    func delete(
        endpoint: Endpoint
    ) -> AnyPublisher<Data, Error> {
        performRequest(
            endpoint: endpoint,
            method: "DELETE",
            body: nil
        )
    }

    // MARK: - Private Methods

    private func performRequest(
        endpoint: Endpoint,
        method: String,
        body: Data?
    ) -> AnyPublisher<Data, Error> {

        print(
            "🌐 [DataProvider] Performing \(method) request to: \(endpoint.url.absoluteString)"
        )

        var request = URLRequest(url: endpoint.url)
        request.httpMethod = method
        request.httpBody = body

        // Add default headers
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Accept"
        )

        // Merge endpoint-specific headers
        endpoint.headers.forEach { key, value in
            request.setValue(
                value,
                forHTTPHeaderField: key
            )
        }

        print(
            "🌐 [DataProvider] Request headers: \(request.allHTTPHeaderFields ?? [:])"
        )

        return session.dataTaskPublisher(for: request)
            .tryMap { [weak self] output in

                print(
                    "📡 [DataProvider] Received response, attempting to handle..."
                )

                return try self?.handleURLResponse(
                    output: output,
                    url: endpoint.url
                ) ?? output.data
            }
            .retry(retryCount)
            .eraseToAnyPublisher()
    }

    private func handleURLResponse(
        output: URLSession.DataTaskPublisher.Output,
        url: URL
    ) throws -> Data {

        guard let response = output.response as? HTTPURLResponse else {
            print("❌ [DataProvider] Response is not HTTPURLResponse")

            throw NetworkError.badURLResponse(url: url)
        }

        print(
            "🌐 [DataProvider] Response status code: \(response.statusCode)"
        )

        guard (200...299).contains(response.statusCode) else {

            print(
                "❌ [DataProvider] Bad status code: \(response.statusCode)"
            )

            if let responseString = String(
                data: output.data,
                encoding: .utf8
            ) {
                print(
                    "❌ [DataProvider] Response body: \(responseString)"
                )
            }

            throw NetworkError.badURLResponse(url: url)
        }

        print(
            "✅ [DataProvider] Response OK, data size: \(output.data.count) bytes"
        )

        return output.data
    }
}

// MARK: - MockDataProvider
/// Mock implementation for testing
/// This allows you to test services without making real network calls
class MockDataProvider: DataProvider {

    var mockResponse: Result<Data, Error>?
    var capturedEndpoint: Endpoint?
    var capturedBody: Data?
    var callCount: Int = 0

    func get(endpoint: Endpoint) -> AnyPublisher<Data, Error> {
        captureRequest(endpoint: endpoint, body: nil)
        return respond()
    }

    func post(endpoint: Endpoint, body: Data) -> AnyPublisher<Data, Error> {
        captureRequest(endpoint: endpoint, body: body)
        return respond()
    }

    func put(endpoint: Endpoint, body: Data) -> AnyPublisher<Data, Error> {
        captureRequest(endpoint: endpoint, body: body)
        return respond()
    }

    func delete(endpoint: Endpoint) -> AnyPublisher<Data, Error> {
        captureRequest(endpoint: endpoint, body: nil)
        return respond()
    }

    // MARK: - Private Methods

    private func captureRequest(endpoint: Endpoint, body: Data?) {
        self.capturedEndpoint = endpoint
        self.capturedBody = body
        self.callCount += 1
    }

    private func respond() -> AnyPublisher<Data, Error> {
        if let mockResponse = mockResponse {
            return mockResponse
                .publisher
                .eraseToAnyPublisher()
        } else {
            return Fail(
                error: NetworkError.unknown(
                    NSError(
                        domain: "MockDataProvider",
                        code: -1,
                        userInfo: [
                            NSLocalizedDescriptionKey: "No mock response set"
                        ]
                    )
                )
            )
            .eraseToAnyPublisher()
        }
    }
}
