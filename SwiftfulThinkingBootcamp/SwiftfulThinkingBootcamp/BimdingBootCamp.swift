//
//  BimdingBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 19/01/26.
//

import SwiftUI

struct BimdingBootCamp: View {
    @State var backgroundColor: Color = .green
    @State var title: String = "This is the title"
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text(title)
                    .font(.title)
                    .foregroundColor(.white)
                ButtonView(backgroundColor: $backgroundColor, title: $title)
            }
        }
    }
}

struct ButtonView: View {
    @Binding var backgroundColor: Color
    @Binding var title: String
    var body: some View {
        Button(action: {
            backgroundColor = .yellow
            title = "New title"
        },
               label:{
            Text("Button")
                .foregroundColor(Color.white)
                .padding()
                .padding(.horizontal)
                .background(Color.blue)
                .cornerRadius(10)
        } )
    }
}

#Preview {
    BimdingBootCamp()
}
