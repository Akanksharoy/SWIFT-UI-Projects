//
//  BadgesBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 25/05/26.
//

import SwiftUI

struct BadgesBootCamp: View {
    var body: some View {
        List {
            Text("Hello World").badge(5)
            Text("Hello World")
            Text("Hello World")
            Text("Hello World")
            Text("Hello World")
        }
//        TabView {
//            Color.red
//                .tabItem {
//                    Image(systemName: "heart.fill")
//                    Text("Hello")
//                }.badge(2)
//            
//            Color.green
//                .tabItem {
//                    Image(systemName: "person.fill")
//                    Text("Person")
//                }
//            
//            Color.blue
//                .tabItem {
//                    Image(systemName: "trash.circle")
//                    Text("Person")
//                }
//        }
    }
}

#Preview {
    BadgesBootCamp()
}
