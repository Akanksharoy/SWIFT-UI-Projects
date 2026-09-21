//
//  TabViewBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 14/03/26.
//

import SwiftUI

struct TabViewBootcamp: View {
    @State var selectedTabItem:Int = 0
    var body: some View {
        TabView(selection: $selectedTabItem){
           HomeView(tabItem: $selectedTabItem)
                .tabItem{
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            Text("Profile")
                .tabItem{
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(1)
            Text("Browse")
                .tabItem{
                    Image(systemName: "globe")
                    Text("Profile")
                }
                .tag(2)
        }
    }
}

#Preview {
    TabViewBootcamp()
}
struct HomeView: View{
    @Binding var tabItem:Int
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
            
            Text("Hometab")
                .font(.largeTitle)
                .foregroundColor(.white)
            
            Button (action: {
                tabItem = 2
            }, label: {
                Text("Go to profile")
                    .font(.headline)
                    .padding()
                    .padding(.horizontal)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
            
        }
    }
    
    
}
