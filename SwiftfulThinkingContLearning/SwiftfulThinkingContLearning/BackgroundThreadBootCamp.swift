//
//  BackgroundThreadBootCamp.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 18/07/26.
//

import SwiftUI
import Combine

class  BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray:[String] = []
    
    func fetchData(){
        DispatchQueue.global().async{
            let newData = self.downloadData()
            self.dataArray = newData
        }
        
    }
    private func downloadData() -> [String]{
        var data:[String] = []
        
        for x in 0..<100 {
            data.append("\(x)")
        }
        return data
    }
}

struct BackgroundThreadBootCamp: View {
    @StateObject var viewModel: BackgroundThreadViewModel = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        viewModel.fetchData()
                    }
                
                ForEach(viewModel.dataArray, id: \.self){ item in
                    Text(item)
                        .foregroundColor(Color.red)
                    
                }
                
            }
        }
    }
}

#Preview {
    BackgroundThreadBootCamp()
}
