//
//  ListRowview.swift
//  SwiftUITodoList
//
//  Created by Akanksha on 03/06/26.
//

import SwiftUI

struct ListRowView: View {
    let item: ItemModel
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
            Text(item.title)
            Spacer()
        }
        .font(.title)
        .padding(.vertical, 8)
    }
}

#Preview {
    var item1 = ItemModel(title: "First Item", isCompleted: true)
    var item2 = ItemModel(title: "Second Item", isCompleted: false)
    Group {
        ListRowView(item: item1)
        ListRowView(item: item2)

    }
}
