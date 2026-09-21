//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Akanksha on 25/08/26.
//

import Combine
import Foundation


final class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = [
        StatisticModel(title: "title", value: "value", percentageChange: 1),
        StatisticModel(title: "title2", value: "value", percentageChange: -7),
        StatisticModel(title: "title3", value: "value"),
        StatisticModel(title: "portfolio", value: "value 4", percentageChange: 11)
        
    ]
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var marketData: MarketDataModel? = nil
    @Published var sortOption: SortOption = .holdings
    
    private let serviceFactory: ServiceFactory
    private let coinDataService: CoinDataServiceProtocol
    private let marketDataService: MarketDataServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private let portfolioDataService = PortfolioDataService()
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    init(serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
        self.coinDataService = serviceFactory.coinDataService()
        self.marketDataService = serviceFactory.marketDataService()
    }
    
    convenience init() {
        self.init(serviceFactory: .production())
        addSubscribers()
    }
    
    func addSubscribers() {
        $searchText
            .combineLatest($allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // Keep portfolioCoins in sync with saved portfolio holdings and allCoins
        portfolioDataService.$savedEntities
            .combineLatest($allCoins)
            .map { savedEntities, allCoins in
                self.mapAllCoinsToPortfolio(allCoins: allCoins, portfolioEntities: savedEntities)
            }
            .sink { [weak self] mapped in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: mapped)
            }
            .store(in: &cancellables)
        
        $marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self]  (returnedStats) in
                guard let self else { return }
                self.statistics = returnedStats
                self.isLoading = false
            }
            .store(in: &cancellables)
        
        
    }
    private func filterAndSortCoins(text: String, coins:[CoinModel], sortOption: SortOption) -> [CoinModel] {
        var filteredCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sortOption, coins: &filteredCoins)
        return filteredCoins
    }
    
    private func filterCoins(text: String, coins:[CoinModel]) -> [CoinModel]{
        guard !text.isEmpty else {
            return coins
        }
        let lowercasedText = text.lowercased()
        return coins.filter { (coin) -> Bool in
            coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: {$0.rank < $1.rank})
        case .rankReversed, .holdingsReversed:
            coins.sort(by: {$0.rank > $1.rank})
        case .price:
            coins.sort(by: {$0.currentPrice < $1.currentPrice})
        case .priceReversed:
            coins.sort(by: {$0.currentPrice > $1.currentPrice})
        }
    }
    
    private func mapAllCoinsToPortfolio(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allCoins.compactMap { coin -> CoinModel? in
            guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else { return nil }
            return coin.updateHoldings(amount: entity.amount)
        }
    }
    
    func updatePortfolio(coin:CoinModel, amount: Double){
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
        // Combine pipeline will automatically refresh portfolioCoins
    }
    
    // MARK: - Reload Data
    
    func reloadData() {
        print("🏠 [HomeViewModel] reloadData() called")
        isLoading = true
        
        print("🏠 [HomeViewModel] Calling coinDataService.getCoins()...")
        coinDataService.getCoins()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        print("❌ [HomeViewModel] Error loading coins: \(error)")
                    }
                    
                    self?.isLoading = false
                },
                receiveValue: { [weak self] coins in
                    print("✅ [HomeViewModel] Loaded \(coins.count) coins")
                    self?.allCoins = coins
                }
            )
            .store(in: &cancellables)
        
        print("🏠 [HomeViewModel] Calling marketDataService.getData()...")
        //updated the market data
        marketDataService.getMarketData()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("❌ [HomeViewModel] Error loading market data: \(error)")
                    }
                },
                receiveValue: { [weak self] data in
                    print("✅ [HomeViewModel] Loaded market data")
                    guard let marketData = data else { return }
                    self?.marketData = data
                }
            )
            .store(in: &cancellables)
        
        //        HapticManager.notification(type: .success)
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats:[StatisticModel] = []
        
        guard let data = marketData else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue =
        portfolioCoins.map { $0.currentHoldingsValue }
            .reduce(0,+)
        
        let previousValue =
        portfolioCoins.map { (coin) -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentChange = coin.priceChangePercentage24H ?? 0 / 100
            let previousValue = currentValue / (1+percentChange)
            return previousValue}
        .reduce(0, +)
        
        let percentageChange = (portfolioValue - previousValue)/previousValue
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        switch sortOption {
        case .holdings:
            return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue})
        case .holdingsReversed:
            return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue})
        default :
            return coins
        }
    }
    
}
