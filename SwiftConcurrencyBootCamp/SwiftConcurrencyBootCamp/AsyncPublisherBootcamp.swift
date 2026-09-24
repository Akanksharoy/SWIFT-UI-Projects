//
//  AsyncPublisherBootcamp.swift
//  SwiftConcurrencyBootCamp
//
//  Created by Akanksha on 24/09/26.
//

import SwiftUI
import Combine

class AsyncPublisherDataManager {
    
    @Published var myData: [String] = []
    
    func addData() async {
        myData.append("Apple")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("Banana")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("Orange")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("Watermelon")
    }
    
}

class AsyncPublisherBootcampViewModel: ObservableObject {
    @MainActor @Published var dataArray:[String] = []
    let manager = AsyncPublisherDataManager()
    var cancellables = Set<AnyCancellable>()
    init() {
        addSubscriber()
    }
    
    func addSubscriber() {
        Task {
            for await value in manager.$myData.values {
                await MainActor.run(body: {
                    self.dataArray = value
                })
            }
        }
        
        //        manager.$myData
        //            .receive(on: DispatchQueue.main)
        //            .sink(receiveValue: { [weak self] data in
        //                self?.dataArray.append(contentsOf: data)
        //            })
        //            .store(in: &cancellables)
    }
    
    func start() async {
        await manager.addData()
    }
}

struct AsyncPublisherBootcamp: View {
    
    @StateObject private var viewModel = AsyncPublisherBootcampViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.dataArray, id: \.self) {
                    Text($0)
                        .font(.headline)
                }
            }
        }
        .task {
            await viewModel.start()
        }
    }
}
#Preview {
    AsyncPublisherBootcamp()
}
