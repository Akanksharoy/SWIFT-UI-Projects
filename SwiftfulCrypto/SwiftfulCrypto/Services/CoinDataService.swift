//
//  CoinDataService.swift
//  SwiftfulCrypto
//
//  Created by Akanksha on 25/08/26.
//
/*
 https://www.swiftful-thinking.com/blog/learn-combine-for-swift-in-6-hours
 */

import Foundation
import Combine

// MARK: - CoinDataServiceProtocol

/// Protocol defining the interface for coin data service
/// This enables testing by allowing mock implementations
protocol CoinDataServiceProtocol {
    func getCoins() -> AnyPublisher<[CoinModel], Error>
}

// MARK: - CoinDataService

/// Service for fetching coin market data from CoinGecko API
/// Uses dependency injection to receive environmentConfiguration and dataProvider
class CoinDataService: BaseService, CoinDataServiceProtocol {

    // MARK: - Initialization

    /// DEPENDENCY INJECTION in action:
    /// 1. We receive environmentConfiguration and dataProvider from the factory
    /// 2. We pass them up to the BaseService superclass
    /// 3. The service can now use these injected dependencies for API calls
    override init(
        environmentConfiguration: EnvironmentConfiguration,
        dataProvider: DataProvider
    ) {
        super.init(
            environmentConfiguration: environmentConfiguration,
            dataProvider: dataProvider
        )
    }

    // MARK: - API Methods

    /// Fetches all coins from the CoinGecko API
    /// Returns a publisher that emits coin data or an error
    /// Uses the injected dataProvider and environmentConfiguration
    func getCoins() -> AnyPublisher<[CoinModel], Error> {

        print("🔵 [CoinDataService] getCoins() called")

        // Step 1: Build endpoint using the factory method from Endpoint extension
        let endpoint = Endpoint.coinsMarkets(
            baseURL: environmentConfiguration.baseURL,
            vsCurrency: "usd",
            order: "market_cap_desc",
            perPage: 250,
            page: 1,
            sparkline: true,
            priceChangePercentage: "24h"
        )

        print("🔵 [CoinDataService] Endpoint URL: \(endpoint.url.absoluteString)")
        print("🔵 [CoinDataService] Base URL: \(environmentConfiguration.baseURL.absoluteString)")

        // Step 2: Make API call using the INJECTED dataProvider and return the publisher
        return dataProvider.get(endpoint: endpoint)
            .decode(
                type: [CoinModel].self,
                decoder: JSONDecoder()
            )
            .handleEvents(
                receiveOutput: { coins in
                    print("🟢 [CoinDataService] Received \(coins.count) coins")
                },
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("🟢 [CoinDataService] Successfully completed API call")

                    case .failure(let error):
                        print("🔴 [CoinDataService] ERROR: \(error.localizedDescription)")
                        print("🔴 [CoinDataService] Full error: \(error)")
                    }
                }
            )
            .eraseToAnyPublisher()
    }
}

// MARK: - MockCoinDataService

/// Mock implementation of CoinDataServiceProtocol for testing
///
/// Example usage in tests:
///
/// let mockService = MockCoinDataService()
/// mockService.mockCoins = [/* test coins */]
/// // Or simulate an error:
/// mockService.mockError = NetworkError.invalidResponse
/// let viewModel = HomeViewModel(mockCoinDataService: mockService)

class MockCoinDataService: CoinDataServiceProtocol {

    var mockCoins: [CoinModel] = []
    var mockError: Error?
    var getCoinsCallCount = 0

    func getCoins() -> AnyPublisher<[CoinModel], Error> {

        getCoinsCallCount += 1

        if let error = mockError {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }

        return Just(mockCoins)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
