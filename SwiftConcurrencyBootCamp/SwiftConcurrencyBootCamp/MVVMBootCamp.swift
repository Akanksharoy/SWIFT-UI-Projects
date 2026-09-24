//
//  MVVMBootCamp.swift
//  SwiftConcurrencyBootCamp
//
//  Created by Akanksha on 24/09/26.
//

import SwiftUI
import Combine

class MyClassDataManager {
    func getData() async throws-> String {
        return "Hello Data"
    }
}
actor MyActorManager {
    func getData() async throws -> String {
        return "Hello Data"
    }
}

@MainActor
class MVVMBootCampViewModel: ObservableObject {
    let classManager: MyClassDataManager = MyClassDataManager()
    let actorManager: MyActorManager = MyActorManager()
    private var tasks: [Task<Void, Never>] = []
    
    @Published var data: String = "InitialData"
    
    func onButtonPressed()  {
        let task = Task {
            do {
//                data = try await classManager.getData()
                data = try await actorManager.getData() //no error here as the switch between the background thread and since view model is in main thread automatically happens since the caller is on main actor so come back to main actor
            }
            catch {
                print(error.localizedDescription)
            }
        }
        tasks.append(task)
    }
    
}
struct MVVMBootCamp: View {
    @StateObject var viewModel = MVVMBootCampViewModel()
    var body: some View {
        Button {
            viewModel.onButtonPressed()
        } label: {
            Text(viewModel.data)
        }

    }
}

#Preview {
    MVVMBootCamp()
}
