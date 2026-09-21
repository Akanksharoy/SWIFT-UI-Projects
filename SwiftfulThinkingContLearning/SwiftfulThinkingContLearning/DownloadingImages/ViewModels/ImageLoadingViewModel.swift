//
//  ImageLoadingViewModel.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 31/08/26.
//

import Combine
import SwiftUI
class ImageLoadingViewModel: ObservableObject {
    
    @Published var image:UIImage? = nil
    @Published var isLoading:Bool = false
    var cancellables = Set<AnyCancellable>()
    let photoModelCacheManager = PhotomodelCacheManager.instance
    let urlString: String
    let imageKey: String
    
    init(url: String, key:String) {
        print("[ImageLoadingViewModel] init with url=\(url)")
        urlString = url
        imageKey = key
        getImage()
    }
    
    func getImage() {
        if let savedImage = photoModelCacheManager.get(key: imageKey) {
            image = savedImage
            print("Getting image from cache")
        }
        else {
            downloadImage()
        }
        
    }
    
    func downloadImage(){
        print("[ImageLoadingViewModel] downloadImage() called")
        isLoading = true
        print("[ImageLoadingViewModel] isLoading set to true")
        guard let url = URL(string: urlString) else {
            print("[ImageLoadingViewModel] Invalid URL string: \(urlString)")
            return
        }
        print("[ImageLoadingViewModel] Starting data task for URL: \(url.absoluteString)")
        URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in
                print("[ImageLoadingViewModel] Received data bytes: \(data.count)")
                if let http = response as? HTTPURLResponse {
                    print("[ImageLoadingViewModel] HTTP status: \(http.statusCode)")
                }
                let img = UIImage(data: data)
                print("[ImageLoadingViewModel] UIImage created: \(img != nil)")
                return img
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    print("[ImageLoadingViewModel] sink finished")
                case .failure(let error):
                    print("[ImageLoadingViewModel] sink failed with error: \(error)")
                }
            } receiveValue: { [weak self] returnedImage in
                print("[ImageLoadingViewModel] receiveValue image is nil? \(returnedImage == nil)")
                guard let self = self, let image = returnedImage else { return }
                self.image = returnedImage
                self.photoModelCacheManager.add(key: self.imageKey, value: returnedImage)
                if returnedImage != nil { print("[ImageLoadingViewModel] Image assigned to published property") }
            }
            .store(in: &cancellables)
        // Subscription stored to keep the request alive
        
    }
}

