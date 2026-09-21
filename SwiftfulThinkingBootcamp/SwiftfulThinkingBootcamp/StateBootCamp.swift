//
//  StateBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 19/01/26.
//

import SwiftUI

struct StateBootCamp: View {
    @State var backgroundColor:Color = .red
    @State var count = 0
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20){
                Text("Title")
                    .font(Font.title)
                Text("Count \(count)")
                    .underline()
                HStack(spacing: 20){
                    Button("Button 1"){
                        backgroundColor = .blue
                        count += 1
                    }
                    Button("Button 2"){
                        backgroundColor = .green
                        count -= 1
                    }
                }
                
            }
            .foregroundColor(.white)
        }
    }
}

#Preview {
    StateBootCamp()
}
