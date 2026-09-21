//
//  DoCatchTrythrowsBootCampView.swift
//  SwiftConcurrencyBootCamp
//
//  Created by Akanksha on 16/09/26.
//

import SwiftUI
import Combine

class DoCatchTryThrowsBootCampDataManager {
    
    let isActive: Bool = false
    
    func getTitle() -> (title:String?, error: Error?) {
        if isActive {
            return ("New Text", nil)
        } else {
            return (nil, URLError(.badURL))
        }
    }
    
    func getTitle2() -> Result<String, Error> {
        if isActive {
            return .success("New Text")
        } else {
            return .failure(URLError(.badURL))
        }
    }
    
    func getTitle3() throws -> String{
        if isActive {
            return ("New Text")
        }
        else {
            throw URLError(.badURL)
        }
    }
    func getTitle4() throws -> String{
        if isActive {
            return ("FINAL TEXT")
        }
        else {
            throw URLError(.badURL)
        }
    }
}


class DoCatchTryThrowsBootCampViewModel: ObservableObject {
    @Published var title: String = "Starting Text"
    
    private let dataManager: DoCatchTryThrowsBootCampDataManager = DoCatchTryThrowsBootCampDataManager()
        
    func fetchTitle() {
       /*
        let result = dataManager.getTitle2()
        switch result {
        case .success(let title):
            self.title = title
        case .failure(let error):
            print(error)
        }
        */
        
        // optional try
        // then you don't need a do catch block
        let newTitle = try? dataManager.getTitle3()
        if let newTitle = newTitle {
            self.title = newTitle
        }
        do {
            let newTitle = try dataManager.getTitle3()
            self.title = newTitle
            let nextTitle = try dataManager.getTitle4()
            self.title = nextTitle
        }
        catch let error {
            print(error)
            self.title = error.localizedDescription
        }
       
    }
}

struct DoCatchTrythrowsBootCampView: View {
    @StateObject var viewModel: DoCatchTryThrowsBootCampViewModel = DoCatchTryThrowsBootCampViewModel()
    var body: some View {
        Text(viewModel.title)
            .frame(width:300, height: 300)
            .background(Color.blue)
            .onTapGesture {
                viewModel.fetchTitle()
            }
    }
}

#Preview {
    DoCatchTrythrowsBootCampView()
}
