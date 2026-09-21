//
//  OnAppearBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 15/03/26.
//

import SwiftUI

struct OnAppearBootcamp: View {
    @State var myText: String = "Start Text"
    var body: some View {
        NavigationView{
            ScrollView {
                Text(myText)
                    .font(.largeTitle)
                    .padding()
                    
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.myText = "Hello World"
                }
            }
            .navigationTitle("On Appear Bootcamp")
        }
    }
}

#Preview {
    OnAppearBootcamp()
}
