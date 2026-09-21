//
//  ExttractedFuncBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 19/01/26.
//

import SwiftUI

struct ExttractedFuncBootCamp: View {
    @State var backgroundColor = Color.pink
    
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            contentLayer
        }
    }
    func buttonPressed() {
        backgroundColor = .yellow
    }
    var contentLayer: some View {
        VStack {
            Text("Title")
                .font(.largeTitle)
            Button(action: {
                buttonPressed()
            },label: {
                Text("Press me")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                
            })
        }
    }
}

#Preview {
    ExttractedFuncBootCamp()
}
