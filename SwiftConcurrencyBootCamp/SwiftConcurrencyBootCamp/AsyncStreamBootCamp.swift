//
//  AsyncStreamBootCamp.swift
//  SwiftConcurrencyBootCamp
//
//  Created by Akanksha on 24/09/26.
//

import SwiftUI
import Combine
class AsyncStreamDataManager {
    func getfakeData() -> Int{
        return 12345
    }
    
}
@MainActor final class AsyncStreamBootCampViewModel: ObservableObject {
    @Published private(set) var currentNumber: Int = 0
    let manager = AsyncStreamDataManager()
    func onViewAppear(){
        currentNumber = manager.getfakeData()
    }
}

struct AsyncStreamBootCamp: View {
    @StateObject private var viewModel = AsyncStreamBootCampViewModel()
    var body: some View {
        Text(viewModel.currentNumber)
    }
}

#Preview {
    AsyncStreamBootCamp()
}
