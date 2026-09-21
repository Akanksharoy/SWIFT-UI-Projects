//
//  SwiftUITodoListApp.swift
//  SwiftUITodoList
//
//  Created by Akanksha on 02/06/26.
//

import SwiftUI



@main
struct SwiftUITodoListApp: App {
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .navigationViewStyle(.stack)
            .environmentObject(listViewModel)
        }
    }
}
