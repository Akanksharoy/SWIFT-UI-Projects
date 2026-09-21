//
//  DownLoadingImagesViewModel.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 30/08/26.
//
import Combine
import Foundation

class DownLoadingImagesViewModel: ObservableObject {
    @Published var photoModel:[PhotoModel] = []
    private var cancellables = Set<AnyCancellable>()

    let dataService = PhotoModelDataService.instance
    
    init(){
        addSubscribers()
    }
    func addSubscribers() {
        dataService.$photos.sink(receiveValue: { [weak self] (photos) in
            self?.photoModel = photos
        })
        .store(in: &cancellables)
    }
    
}
