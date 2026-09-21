//
//  MarketDataService.swift
//  SwiftfulCrypto
//
//  Created by Akanksha on 09/09/26.
//


import Foundation
import Combine

// MARK: - MarketDataServiceProtocol

/// Protocol defining the interface for coin data service
/// This enables testing by allowing mock implementations
protocol MarketDataServiceProtocol {
    func getMarketData() -> AnyPublisher<MarketDataModel?, Error>
}

// MARK: - MarketDataService

/// Service for fetching coin market data from CoinGecko API
/// Uses dependency injection to receive environmentConfiguration and dataProvider
class MarketDataService: BaseService, MarketDataServiceProtocol {

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
    func getMarketData() -> AnyPublisher<MarketDataModel?, Error> {
        
        print("🔵 [MarketDataService] getCoins() called")
        
        // Step 1: Build endpoint using the factory method from Endpoint extension
        let endpoint = Endpoint.global(
            baseURL: environmentConfiguration.baseURL
        )
        
        print("🔵 [MarketDataService] Endpoint URL: \(endpoint.url.absoluteString)")
        
        // Step 2: Make API call using the INJECTED dataProvider and return the publisher
        return dataProvider.get(endpoint: endpoint)
            .decode(
                type: GlobalData.self,
                decoder: JSONDecoder()
            )
            .map{$0.data}
            .handleEvents(
                receiveOutput: { data in
                    print("🟢 [MarketDataService] Received market data")
                },
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("🟢 [MarketDataService] Successfully completed API call")

                    case .failure(let error):
                        print("🔴 [MarketDataService] ERROR: \(error.localizedDescription)")
                        print("🔴 [MarketDataService] Full error: \(error)")
                    }
                }
            )
            .eraseToAnyPublisher()
    }
}

// MARK: - MockMarketDataService

/// Mock implementation of MarketDataServiceProtocol for testing
///
/// Example usage in tests:
///
/// let mockService = MockMarketDataService()
/// mockService.mockCoins = [/* test coins */]
/// // Or simulate an error:
/// mockService.mockError = NetworkError.invalidResponse
/// let viewModel = HomeViewModel(mockMarketDataService: mockService)

class MockMarketDataService: MarketDataServiceProtocol {

    var mockMarketdata: MarketDataModel?
    var mockError: Error?
    var getDataCallCount = 0

    func getMarketData() -> AnyPublisher<MarketDataModel?, Error> {

        getDataCallCount += 1

        if let error = mockError {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }

        return Just(mockMarketdata)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
