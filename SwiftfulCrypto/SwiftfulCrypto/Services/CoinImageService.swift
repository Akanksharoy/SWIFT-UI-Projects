//
//  CoinImageService.swift
//  SwiftfulCrypto
//
//  Created by Akanksha on 02/09/26.

import Foundation
import SwiftUI
import Combine

// MARK: - CoinImageServiceProtocol

/// Protocol defining the interface for coin image service
/// This enables testing by allowing mock implementations
protocol CoinImageServiceProtocol {
    func getImage() -> AnyPublisher<UIImage?, Error>
}

// MARK: - CoinImageService

/// Service for downloading and caching coin images
/// Uses dependency injection to receive environmentConfiguration and dataProvider
class CoinImageService: BaseService, CoinImageServiceProtocol {

    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String

    // MARK: - Initialization

    /// DEPENDENCY INJECTION in action:
    /// 1. We receive environmentConfiguration and dataProvider from the factory
    /// 2. We pass them up to the BaseService superclass
    /// 3. We also receive the coin model for this specific image download
    init(
        environmentConfiguration: EnvironmentConfiguration,
        dataProvider: DataProvider,
        coin: CoinModel
    ) {
        self.coin = coin
        self.imageName = coin.id

        super.init(
            environmentConfiguration: environmentConfiguration,
            dataProvider: dataProvider
        )
    }

    // MARK: - API Methods

    /// Fetches coin image from cache or downloads it
    /// Returns a publisher that emits the image or an error
    func getImage() -> AnyPublisher<UIImage?, Error> {

        // Check if image is already cached
        if let savedImage = fileManager.getImage(
            imageName: imageName,
            folderName: folderName
        ) {
            return Just(savedImage)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }

        // Download if not cached
        return downloadCoinImage()
    }

    // MARK: - Private Methods

    private func downloadCoinImage() -> AnyPublisher<UIImage?, Error> {

        guard let url = URL(string: coin.image) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        // Create endpoint using the helper method
        let endpoint = Endpoint.coinImage(imageURL: url)

        return dataProvider.get(endpoint: endpoint)
            .tryMap { data -> UIImage? in
                UIImage(data: data)
            }
            .handleEvents(
                receiveOutput: { [weak self] image in

                    guard let self = self,
                          let downloadedImage = image else {
                        return
                    }

                    self.fileManager.saveImage(
                        image: downloadedImage,
                        imageName: self.imageName,
                        folderName: self.folderName
                    )

                    print(
                        "🟢 [CoinImageService] Downloaded and cached image for \(self.coin.name)"
                    )
                },
                receiveCompletion: { completion in

                    if case .failure(let error) = completion {
                        print(
                            "🔴 [CoinImageService] ERROR: \(error.localizedDescription)"
                        )
                    }
                }
            )
            .eraseToAnyPublisher()
    }
}

// MARK: - MockCoinImageService

/// Mock implementation of CoinImageServiceProtocol for testing
class MockCoinImageService: CoinImageServiceProtocol {

    var mockImage: UIImage?
    var mockError: Error?
    var getImageCallCount = 0

    func getImage() -> AnyPublisher<UIImage?, Error> {

        getImageCallCount += 1

        if let error = mockError {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }

        return Just(mockImage)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
