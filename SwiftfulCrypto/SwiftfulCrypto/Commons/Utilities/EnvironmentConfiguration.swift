//
//  EnvironmentConfiguration.swift
//  SwiftfulCrypto
//
//  Created by Akanksha on 03/09/26.
//


import Foundation

// MARK: - EnvironmentConfiguration

/// Configuration for API environment (base URL, credentials, headers)
/// This is injected into services to provide environment-specific settings
struct EnvironmentConfiguration {

    let baseURL: URL
    let defaultHeaders: [String: String]
    let apiVersion: String

    init(
        baseURL: URL,
        defaultHeaders: [String: String] = [:],
        apiVersion: String = "v3"
    ) {
        self.baseURL = baseURL
        self.defaultHeaders = defaultHeaders
        self.apiVersion = apiVersion
    }

    // MARK: - Factory Methods

    /// Production environment configuration for CoinGecko API
    static func production() -> EnvironmentConfiguration {
        EnvironmentConfiguration(
            baseURL: URL(string: "https://api.coingecko.com")!,
            defaultHeaders: [
                "X-Environment": "production"
            ],
            apiVersion: "v3"
        )
    }

    /// Development environment configuration (same as production for CoinGecko)
    static func development() -> EnvironmentConfiguration {
        EnvironmentConfiguration(
            baseURL: URL(string: "https://api.coingecko.com")!,
            defaultHeaders: [
                "X-Environment": "development"
            ],
            apiVersion: "v3"
        )
    }

    /// Staging environment configuration
    /// Note: CoinGecko doesn't have staging, but this shows the pattern
    static func staging() -> EnvironmentConfiguration {
        EnvironmentConfiguration(
            baseURL: URL(string: "https://api.coingecko.com")!,
            defaultHeaders: [
                "X-Environment": "staging"
            ],
            apiVersion: "v3"
        )
    }
}
