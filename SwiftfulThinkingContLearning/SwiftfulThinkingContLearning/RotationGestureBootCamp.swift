//
//  RotationGestureBootCamp.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 04/07/26.
//

import SwiftUI

struct RotationGestureBootCamp: View {
    @State var angle:Angle = Angle(degrees: 0)
    var body: some View {
                Text("Hello, World!")
                    .font(.title)
                    .padding(40)
                    .background(Color.blue)
                    .rotationEffect(angle)
                    .gesture(
                        RotationGesture()
                            .onChanged{
                                value in
                                angle = value
                            }
                            .onEnded{
                                value in
                                angle = Angle(degrees: 0)
                            }
                        
                    )
    }
}

#Preview {
    RotationGestureBootCamp()
}
