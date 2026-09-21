//
//  NoItemsView.swift
//  SwiftUITodoList
//
//  Created by Akanksha on 12/06/26.
//

import SwiftUI

struct NoItemsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(systemName: "magnifyingglass.circle")
                    .font(.largeTitle)
                Text("There are no items")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Are you a productive person? I think you can click on add button to add your todo items to the list!")
                    .font(.headline)
                
            }
            .multilineTextAlignment(.center)
            .padding(40)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    NoItemsView()
}
