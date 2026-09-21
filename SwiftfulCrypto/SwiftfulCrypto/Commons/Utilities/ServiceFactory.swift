//
//  ServiceFactory.swift
//  SwiftfulCrypto
//
//  Created by Akanksha on 03/09/26.
//

//
//  ServiceFactory.swift
//  SwiftfulCrypto
//

import Foundation

// MARK: - ServiceFactoryProtocol

/// Protocol defining the contract for creating services
/// This allows for multiple factory implementations (production, testing, etc.)
protocol ServiceFactoryProtocol {

    func coinDataService() -> CoinDataServiceProtocol

//    func marketDataService() -> MarketDataServiceProtocol
//
//    func coinDetailDataService(
//        coin: CoinModel
//    ) -> CoinDetailDataServiceProtocol

    func coinImageService(
        coin: CoinModel
    ) -> CoinImageServiceProtocol
}

// MARK: - ServiceFactory

/// The SERVICE FACTORY is the HEART of Dependency Injection in this architecture!
///
/// KEY CONCEPTS:
/// 1. The factory owns the shared dependencies (environmentConfiguration, dataProvider)
/// 2. When creating services, it INJECTS these dependencies into them
/// 3. Services don't create their own dependencies - they receive them
/// 4. This makes testing easy: swap the factory's dataProvider with a mock
///
/// BENEFITS:
/// - Single source of truth for configuration
/// - Easy to swap between environments (dev, staging, prod)
/// - Services are testable with mock data providers
/// - Consistent pattern across all services

class ServiceFactory: ServiceFactoryProtocol {

    // MARK: - Shared Dependencies

    /// These are the dependencies that will be injected into all services
    private let environmentConfiguration: EnvironmentConfiguration
    private let dataProviderInstance: DataProvider

    // MARK: - Initialization

    /// The factory is initialized with the dependencies it will inject
    /// This is typically done once at app startup
    init(
        environmentConfiguration: EnvironmentConfiguration,
        dataProvider: DataProvider
    ) {
        self.environmentConfiguration = environmentConfiguration
        self.dataProviderInstance = dataProvider
    }

    // MARK: - Convenience Initializers

    /// Convenience initializer for production use
    /// Creates a factory with production configuration and real URLSession data provider
    static func production() -> ServiceFactory {
        let config = EnvironmentConfiguration.production()
        let dataProvider = URLSessionDataProvider()

        return ServiceFactory(
            environmentConfiguration: config,
            dataProvider: dataProvider
        )
    }

    /// Convenience initializer for development use
    static func development() -> ServiceFactory {
        let config = EnvironmentConfiguration.development()
        let dataProvider = URLSessionDataProvider()

        return ServiceFactory(
            environmentConfiguration: config,
            dataProvider: dataProvider
        )
    }

    /// Convenience initializer for testing with mocks
    /// Pass in a MockDataProvider with predetermined responses
    static func mock(
        mockDataProvider: MockDataProvider
    ) -> ServiceFactory {
        let config = EnvironmentConfiguration.development()

        return ServiceFactory(
            environmentConfiguration: config,
            dataProvider: mockDataProvider
        )
    }

    // MARK: - DataProvider Access

    /// Returns the data provider instance
    /// This method provides access to the shared data provider
    func dataProvider() -> DataProvider {
        return dataProviderInstance
    }

    // MARK: - Service Creation Methods

    /// Creates a CoinDataService instance with injected dependencies
    ///
    /// DEPENDENCY INJECTION FLOW:
    /// 1. Factory is called by the ViewModel
    /// 2. Factory creates service, passing:
    ///    - environmentConfiguration (shared across all services)
    ///    - dataProvider (shared across all services)
    /// 3. Service receives and stores these dependencies
    /// 4. Service can now make API calls using the injected dataProvider
    func coinDataService() -> CoinDataServiceProtocol {
        CoinDataService(
            environmentConfiguration: environmentConfiguration,
            dataProvider: dataProvider()
        )
    }

    /// Creates a MarketDataService instance with injected dependencies
    func marketDataService() -> MarketDataServiceProtocol {
        MarketDataService(
            environmentConfiguration: environmentConfiguration,
            dataProvider: dataProvider()
        )
    }
//
//    /// Creates a CoinDetailDataService instance with injected dependencies
//    /// Takes a coin parameter for the specific coin to fetch details for
//    func coinDetailDataService(
//        coin: CoinModel
//    ) -> CoinDetailDataServiceProtocol {
//        CoinDetailDataService(
//            environmentConfiguration: environmentConfiguration,
//            dataProvider: dataProvider(),
//            coin: coin
//        )
//    }

    /// Creates a CoinImageService instance with injected dependencies
    /// Takes a coin parameter for the specific coin image to download
    func coinImageService(
        coin: CoinModel
    ) -> CoinImageServiceProtocol {
        CoinImageService(
            environmentConfiguration: environmentConfiguration,
            dataProvider: dataProvider(),
            coin: coin
        )
    }
}

// MARK: - Usage Example Comments

/*
 HOW TO USE THE FACTORY:

 // 1. Create a factory (typically done once at app startup in SwiftfulCryptoApp)

 let factory = ServiceFactory.production()


 // 2. Inject the factory into your ViewModels

 let homeViewModel = HomeViewModel(serviceFactory: factory)


 // 3. ViewModels use the factory to create services as needed

 class HomeViewModel {
     private let serviceFactory: ServiceFactory
     private let coinDataService: CoinDataService

     init(serviceFactory: ServiceFactory) {
         self.serviceFactory = serviceFactory
         self.coinDataService = serviceFactory.coinDataService()

         // The service now has access to production dataProvider!
     }
 }


 WHY THIS PATTERN?

 1. TESTABILITY:

    - In production: ServiceFactory.production() uses URLSessionDataProvider
    - In tests: ServiceFactory.mock(mockDataProvider) uses MockDataProvider
    - ViewModels and Services don't care which implementation they get!


 2. FLEXIBILITY:

    - Easy to switch environments (dev, staging, prod)
    - Easy to change network implementation
    - No hardcoded URLs or configuration in services


 3. SINGLE RESPONSIBILITY:

    - Services focus on API logic only
    - Factory handles dependency management
    - Configuration is centralized


 4. CONSISTENCY:

    - All services follow the same pattern
    - Easy to add new services
    - Clear separation of concerns


 TESTING EXAMPLE:

 func testHomeViewModel() {
     // Create mock data provider with predetermined response
     let mockProvider = MockDataProvider()
     let mockCoins = [CoinModel(...)]
     mockProvider.mockResponse =
         .success(try! JSONEncoder().encode(mockCoins))

     // Create factory with mock
     let factory = ServiceFactory.mock(
         mockDataProvider: mockProvider
     )

     // Create ViewModel with mock factory
     let viewModel = HomeViewModel(
         serviceFactory: factory
     )

     // Now all API calls use the mock data - no real network calls!
 }
 */
