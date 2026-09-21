//
//  ListView.swift
//  SwiftUITodoList
//
//  Created by Akanksha on 02/06/26.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
            }
            else {
                List {
                    ForEach (listViewModel.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    listViewModel.updateItem(item: item)
                                }
                            }
                    }
                    .onDelete(perform: {
                        indexSet in
                        listViewModel.delete(indexSet: indexSet)
                        
                    })
                    .onMove(perform: listViewModel.move)
                }
                .listStyle(.plain)
            }
            
            
        }
      
        .navigationTitle("To Do List")
        .navigationBarItems(
            leading: EditButton(), trailing:
                NavigationLink("Add", destination: AddView())
        )

    }

}


#Preview {
    NavigationView{
        ListView()
            .environmentObject(ListViewModel())
    }
}
