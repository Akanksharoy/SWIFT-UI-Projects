//
//  NavigationViewBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 22/01/26.
//

import SwiftUI

struct NavigationViewBootCamp: View {
    var body: some View {
        NavigationView {
            ScrollView {
                NavigationLink("Hello next screen", destination: MySecondScreen())
                Text("Hello, World!")
                Text("Hello, World!")
                Text("Hello, World!")
                Text("Hello, World!")
            }
            .navigationTitle("All inboxes")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(
//                trailing: Image(systemName: "person.fill")
                trailing: NavigationLink(destination: MySecondScreen(), label: {
                    Image(systemName: "person.fill")
                })
            )
        }
    }
}
struct MySecondScreen: View {
    var body: some View {
        ZStack {
            Color.green
                .edgesIgnoringSafeArea(.all)
            Text("Second Screen")
                .font(Font.largeTitle)
                .foregroundColor(.white)
        }
        .navigationTitle("Second Screen")
    }
}

#Preview {
    NavigationViewBootCamp()
}
