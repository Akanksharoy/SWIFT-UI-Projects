//
//  ContextMenuBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 03/03/26.
//

import SwiftUI

struct ContextMenuBootCamp: View {
    var body: some View {
        VStack{
            Image(systemName: "house.fill")
                .font(.title)
            Text("Swiftful Thinking Bootcamp")
                .font(.headline)
            Text("How to use Context menu")
                .font(.subheadline)
        }
        .foregroundColor(.white)
        .padding(30)
        .background(Color.purple.cornerRadius(20))

    }
}

#Preview {
    ContextMenuBootCamp()
}
