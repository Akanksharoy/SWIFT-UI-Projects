//
//  ViewModelBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 15/03/26.
//

import SwiftUI
import Combine

struct FruitModel: Identifiable {
    let id:String = UUID().uuidString
    let name:String
    let count:Int
}

struct ViewModelBootcamp: View {
    //    @State var fruitArray:[FruitModel] = []
    @StateObject  var fruitViewModel = FruitViewModel()
    
    var body: some View {
        NavigationView {
            List {
                if fruitViewModel.isLoading {
                    ProgressView()
                }
                else {
                    ForEach(fruitViewModel.fruitArray){
                        fruit in
                        HStack {
                            Text("\(fruit.count)")
                                .foregroundColor(.red)
                            Text(fruit.name)
                                .font(.headline)
                                .bold()
                        }
                    }
                    .onDelete(perform: fruitViewModel.deleteFruit)
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Fruits")
            .navigationBarItems(trailing:
                                    NavigationLink(destination: RandomScreen(fruitViewModel: fruitViewModel), label: {
                Image(systemName: "arrow.right")
                    .font(.headline)
            })
            )
            
//            .onAppear{
//                fruitViewModel.getFruits()
//            }
        }
        
    }
}


#Preview {
    ViewModelBootcamp()
}

class FruitViewModel: ObservableObject {
    @Published var fruitArray:[FruitModel] = []
    @Published var isLoading: Bool = false
    init(){
        getFruits()
    }
    func getFruits() {
        let fruit1 = FruitModel(name: "Apple", count: 10)
        let fruit2 = FruitModel(name: "Orange", count: 5)
        let fruit3 = FruitModel(name: "Banana", count: 8)
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now()+3){ [weak self] in
            self?.fruitArray.append(fruit1)
            self?.fruitArray.append(fruit2)
            self?.fruitArray.append(fruit3)
            self?.isLoading = false
        }
        
    }
    
    func deleteFruit(at offsets: IndexSet) {
        fruitArray.remove(atOffsets: offsets)
    }
}
struct RandomScreen: View {
    @ObservedObject  var fruitViewModel:FruitViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Color.green.opacity(0.5)
                .ignoresSafeArea()
            VStack {
                ForEach(fruitViewModel.fruitArray) { fruit in
                    Text(fruit.name)
                    
                }
            }
        }
    }
}
