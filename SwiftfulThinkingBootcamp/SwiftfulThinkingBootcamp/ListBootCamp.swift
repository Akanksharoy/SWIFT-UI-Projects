//
//  ListBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 22/01/26.
//

import SwiftUI

struct ListBootCamp: View {
    @State var fruits: [String] = ["Apple", "Orange", "grapes", "mango", "banana"]
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Fruits section")){
                    ForEach(fruits, id: \.self) {
                        fruit in
                        Text(fruit.capitalized)
                    }
                    .onDelete(perform: {
                        indexSet in
                        delete(indexSet: indexSet)
                    })
                    .onMove(perform: {
                        indices, newOffset in
                        fruits.move(fromOffsets: indices, toOffset: newOffset)
                    })
                }
                
            }
            .navigationTitle("Grocery List")
            .navigationBarItems(leading: EditButton())
        }
    }
    
    func delete(indexSet: IndexSet) {
        fruits.remove(atOffsets: indexSet)
    }
}

#Preview {
    ListBootCamp()
}
