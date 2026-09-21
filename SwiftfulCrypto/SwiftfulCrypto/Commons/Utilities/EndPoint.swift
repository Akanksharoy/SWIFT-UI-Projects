//
//  EndPoint.swift
//  SwiftfulCrypto
//
//  Created by Akanksha on 03/09/26.
//


import Foundation

// Represents an API endpoint with base URL, path, query parameters, and headers
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

        return components!.url!
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

    // MARK: - CoinGecko API Endpoints

    /// Endpoint for fetching all coins
    /// GET /api/v3/coins/markets
    static func coinsMarkets(
        baseURL: URL,
        vsCurrency: String = "usd",
        order: String = "market_cap_desc",
        perPage: Int = 250,
        page: Int = 1,
        sparkline: Bool = true,
        priceChangePercentage: String = "24h"
    ) -> Endpoint {

        Endpoint(
            baseURL: baseURL,
            path: "/api/v3/coins/markets",
            queryItems: [
                URLQueryItem(
                    name: "vs_currency",
                    value: vsCurrency
                ),
                URLQueryItem(
                    name: "order",
                    value: order
                ),
                URLQueryItem(
                    name: "per_page",
                    value: "\(perPage)"
                ),
                URLQueryItem(
                    name: "page",
                    value: "\(page)"
                ),
                URLQueryItem(
                    name: "sparkline",
                    value: "\(sparkline)"
                ),
                URLQueryItem(
                    name: "price_change_percentage",
                    value: priceChangePercentage
                )
            ]
        )
    }

    /// Endpoint for fetching global market data
    /// GET /api/v3/global
    static func global(baseURL: URL) -> Endpoint {

        Endpoint(
            baseURL: baseURL,
            path: "/api/v3/global"
        )
    }

    /// Endpoint for fetching coin details
    /// GET /api/v3/coins/{id}
    static func coinDetail(
        baseURL: URL,
        coinId: String,
        localization: Bool = false,
        tickers: Bool = false,
        marketData: Bool = false,
        communityData: Bool = false,
        developerData: Bool = false,
        sparkline: Bool = false
    ) -> Endpoint {

        Endpoint(
            baseURL: baseURL,
            path: "/api/v3/coins/\(coinId)",
            queryItems: [
                URLQueryItem(
                    name: "localization",
                    value: "\(localization)"
                ),
                URLQueryItem(
                    name: "tickers",
                    value: "\(tickers)"
                ),
                URLQueryItem(
                    name: "market_data",
                    value: "\(marketData)"
                ),
                URLQueryItem(
                    name: "community_data",
                    value: "\(communityData)"
                ),
                URLQueryItem(
                    name: "developer_data",
                    value: "\(developerData)"
                ),
                URLQueryItem(
                    name: "sparkline",
                    value: "\(sparkline)"
                )
            ]
        )
    }

    /// Endpoint for downloading coin images
    /// This is a direct URL endpoint for image downloads
    static func coinImage(imageURL: URL) -> Endpoint {

        Endpoint(
            baseURL: imageURL,
            path: ""
        )
    }
}
