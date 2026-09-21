//
//  DarkModeBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 14/03/26.
//

import SwiftUI

struct DarkModeBootcamp: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20){
                    Text("This color is PRIMARY")
                        .foregroundStyle(Color.primary)
                    Text("This color is SECONDARY")
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Dark Mode Bootcamp")
        }
    }
}

#Preview {
    DarkModeBootcamp()
        .preferredColorScheme(.dark)
}
