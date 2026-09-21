//
//  ListsSwipeActionsBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 25/05/26.
//

import SwiftUI

struct ListsSwipeActionsBootCamp: View {
    @State var fruits = ["Apple", "mango", "peach"]
    
    var body: some View {
        List {
            ForEach(fruits, id: \.self) {
                Text($0.capitalized)
            }
//            .onDelete(perform: delete)
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button("Archive"){
                    
                }
                .tint(.green)
                
                Button("Save"){
                    
                }
                .tint(.blue)
                
                Button("Junk"){
                    
                }
                .tint(.black)
                
            }
        }

    }
    
    func delete(indexSet: IndexSet){
        
    }
}

#Preview {
    ListsSwipeActionsBootCamp()
}
