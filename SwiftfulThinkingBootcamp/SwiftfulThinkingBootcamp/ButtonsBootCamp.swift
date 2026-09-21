//
//  ButtonsBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 18/01/26.
//

import SwiftUI

struct ButtonsBootCamp: View {
    @State var title = "Tis is my title"
    var body: some View {

        VStack(spacing: 20) {
            Text(title)
            Button("Press me"){
                title = "I was pressed"
            }
            Button(action: {
                self.title = "Pressed second one"
            }, label: {
                Text("Save".uppercased())
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(
                        Color.white
                    )
                    .padding()
                    .background(
                        Color.blue
                    ).cornerRadius(20)
                    .shadow(radius: 10)
            })
            Button(action: {
                self.title = "Pressed third one"
            }, label: {
                Circle()
                    .fill(Color.white)
                    .frame(width: 75, height: 75)
                    .overlay(
                        Image(systemName: "heart.fill")
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                    )
                    .shadow(radius: 10)
                
            })
        }
    }
}

#Preview {
    ButtonsBootCamp()
}
