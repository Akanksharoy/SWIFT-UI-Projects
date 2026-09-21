//
//  EnvironmentObjectBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 19/03/26.
//

import SwiftUI
import Combine

class EnvironmentViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    init () {
        getData()
    }
    
    func getData() {
        self.dataArray.append("iPhone")
        self.dataArray.append(contentsOf: ["iPad", "MacBook", "Apple Watch"])
    }
    
}
struct EnvironmentObjectBootCamp: View {
    @StateObject var viewModel: EnvironmentViewModel = EnvironmentViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.dataArray, id: \.self) { item in
                    NavigationLink(destination: DetailView(selectedItem: item), label: {
                        Text(item)
                    })
                    
                    
                }
            }
            .navigationTitle("iOS Devices")
        }
        .environmentObject(viewModel)
    }
}

struct DetailView: View {
    let selectedItem: String
    var body: some View {
        ZStack {
            Color.orange.ignoresSafeArea()
            NavigationLink(destination: FinalView(), label: {
                Text(selectedItem)
                    .foregroundColor(.orange)
                    .font(.headline)
                    .padding()
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(30)
            })
            
            
        }
    }
}

struct FinalView: View {
    @EnvironmentObject var viewModel:EnvironmentViewModel
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .teal]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            ScrollView(){
                VStack(spacing: 20) {
                    ForEach(viewModel.dataArray, id: \.self) { item in
                        Text(item)
                            .foregroundColor(.orange)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.white)
                            .cornerRadius(30)
                    }
                }
                .foregroundColor(.white)
                .font(.largeTitle)
            }
            
        }
    }
}
#Preview {
    EnvironmentObjectBootCamp()
}
