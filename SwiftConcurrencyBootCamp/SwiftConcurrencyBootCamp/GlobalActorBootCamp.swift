//
//  GlobalActorBootCamp.swift
//  SwiftConcurrencyBootCamp
//
//  Created by Akanksha on 23/09/26.
//
import Combine
import SwiftUI
actor MyNewDataManager {
    
    func getDataFromDatabase() -> [String]{
        return ["One", "Two", "Three", "Four", "Five", "Six"]
    }
}
class GlobalActorBootCampViewModel: ObservableObject {
    @Published var dataArray:[String] = []
    let manager = MyNewDataManager()
    func getData() async {
        let data = await manager.getDataFromDatabase()
        self.dataArray = data
    }
}
struct GlobalActorBootCamp: View {
    @StateObject private var viewModel = GlobalActorBootCampViewModel()
    
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
            await viewModel.getData()
        }
    }
}

#Preview {
    GlobalActorBootCamp()
}
