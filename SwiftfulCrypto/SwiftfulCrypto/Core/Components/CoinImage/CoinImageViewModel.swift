//
//  CoinImageViewModel.swift
//  SwiftfulCrypto
//
//  Created by Akanksha on 03/09/26.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {

    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false

    private let coin: CoinModel
    private let dataService: CoinImageServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization
    // DEPENDENCY INJECTION:
    // 1. ViewModel receives a ServiceFactory instance
    // 2. Uses factory to create CoinImageService with proper dependencies
    // 3. Service is fully configured with dataProvider and environment config

    init(
        coin: CoinModel,
        serviceFactory: ServiceFactory
    ) {
        self.coin = coin
        self.dataService = serviceFactory.coinImageService(coin: coin)

        self.isLoading = true
        loadImage()
    }

    private func loadImage() {
        image = UIImage(systemName: "bitcoinsign.circle.fill")
        isLoading = false
//        dataService.getImage()
//            .receive(on: DispatchQueue.main)
//            .sink(
//                receiveCompletion: { [weak self] completion in
//                    self?.isLoading = false
//
//                    if case .failure(let error) = completion {
//                        print("❌ [CoinImageViewModel] Error loading image: \(error)")
//                    }
//                },
//                receiveValue: { [weak self] returnedImage in
//                    self?.image = returnedImage
//                }
//            )
//            .store(in: &cancellables)
    }
}
