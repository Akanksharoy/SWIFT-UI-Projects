//
//  PhotoModelDataService.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 30/08/26.
//

import Foundation
import Combine
class PhotoModelDataService {
    @Published private(set) var photos: [PhotoModel] = []
    private var cancellables = Set<AnyCancellable>()
    static let instance = PhotoModelDataService()
    private init() {
        downloadData()
    }
    
    func downloadData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output -> Data in
                guard
                    let response = output.response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300
                else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("PhotoModelDataService error:", error)
                }
            } receiveValue: { [weak self] models in
                self?.photos = models
            }
            .store(in: &cancellables)
    }
}

