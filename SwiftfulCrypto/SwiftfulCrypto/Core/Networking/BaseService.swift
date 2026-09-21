//
//  BaseService.swift
//  SwiftfulCrypto
//
//  Created by Akanksha on 03/09/26.
//


import Foundation
import Combine

// MARK: - BaseService
/// Abstract base class for all API services
/// Provides common functionality and dependency injection for environment config and data provider

/// KEY CONCEPT: This is where dependency injection happens!
/// - Each service receives environmentConfiguration and dataProvider through its initializer
/// - The service stores these dependencies and uses them to make API calls
/// - Subclasses inherit these dependencies automatically
class BaseService {

    // MARK: - Injected Dependencies

    /// Environment configuration (base URL, credentials, headers)
    /// INJECTED via initializer - not created by the service
    let environmentConfiguration: EnvironmentConfiguration

    /// Data provider for making network requests
    /// INJECTED via initializer - allows for testing with mocks
    let dataProvider: DataProvider

    // MARK: - Initialization

    /// Dependency Injection Constructor
    ///
    /// This is the KEY to understanding DI in this architecture:
    /// 1. The service RECEIVES dependencies rather than creating them
    /// 2. The caller (usually a factory) provides the dependencies
    /// 3. This allows for flexible configuration and easy testing
    init(
        environmentConfiguration: EnvironmentConfiguration,
        dataProvider: DataProvider
    ) {
        self.environmentConfiguration = environmentConfiguration
        self.dataProvider = dataProvider
    }

    // MARK: - Helper Methods

    /// Builds common headers by merging default headers with custom headers
    func buildHeaders(
        _ additionalHeaders: [String: String] = [:]
    ) -> [String: String] {

        var headers = environmentConfiguration.defaultHeaders

        // Merge additional headers
        additionalHeaders.forEach { key, value in
            headers[key] = value
        }

        return headers
    }

    /// Creates an endpoint with the base URL and relative path
    func makeEndpoint(
        path: String,
        queryItems: [URLQueryItem] = []
    ) -> Endpoint {

        Endpoint(
            baseURL: environmentConfiguration.baseURL,
            path: path,
            queryItems: queryItems,
            headers: buildHeaders()
        )
    }
}
