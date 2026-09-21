//
//  ListViewModel.swift
//  SwiftUITodoList
//
//  Created by Akanksha on 06/06/26.
//
import Foundation
import Combine
import SwiftUI

class ListViewModel: ObservableObject{
    @Published var items:[ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    let itemsKey = "items_list"
    
    init() {
        geItems()
    }
    
    func geItems(){
        //        let newItems = [ItemModel(title:"This is the first item" , isCompleted: true), ItemModel(title: "This is second", isCompleted: false), ItemModel(title: "This is third", isCompleted: false)]
        //        items.append(contentsOf: newItems)
        
        guard let data = UserDefaults.standard.data(forKey: itemsKey), let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data) else {
            return
        }
        self.items = savedItems
    }
    
    func delete(indexSet:IndexSet){
        items.remove(atOffsets: indexSet)
    }
    
    
    func move(fromOffsets: IndexSet, toOffset: Int) {
        items.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    func addItem(title:String){
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item:ItemModel){
        //        let index = items.firstIndex { (existinItem) -> Bool in
        //            return existinItem.id == item.id
        //        }
        
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
