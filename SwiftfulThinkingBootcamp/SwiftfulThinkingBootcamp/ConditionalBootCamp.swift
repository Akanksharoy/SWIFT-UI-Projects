//
//  ConditionalBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 19/01/26.
//

import SwiftUI

struct ConditionalBootCamp: View {
    @State var showCircle = false
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                showCircle.toggle()
            }, label: {
//                Text("Circle Button " + (showCircle ? "true" : "false"))
                Text("Circle Button \(showCircle.description)")
                
                
            })
            if showCircle == true {
                Circle()
                    .frame(width: 50, height: 50)
            }
            else {
                Rectangle()
                    .frame(width: 50, height: 50)
            }
        }
    }
}

#Preview {
    ConditionalBootCamp()
}
