//
//  MagnificationGestureBootCamp.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 04/07/26.
//

import SwiftUI

struct MagnificationGestureBootCamp: View {
    @State var currentAmount:CGFloat = 0
    var body: some View {
        //        Text("Hello, World!")
        //            .font(.title)
        //            .padding(40)
        //            .background(Color.red)
        //            .scaleEffect(1+currentAmount)
        //            .gesture(
        //                MagnificationGesture()
        //                    .onChanged{
        //                        value in
        //                        print(value)
        //                        currentAmount = value-1
        //
        //                    }
        //            )
        
        VStack(spacing: 20) {
            HStack {
                Circle().frame(width: 35, height: 35)
                Text("Swiftful Thinking")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            Rectangle().frame(height: 300)
                .scaleEffect(1+currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged{
                            value in
                            currentAmount = value-1
                            
                        }
                        .onEnded{ value in
                            currentAmount = 0
                        })
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding(.horizontal)
            .font(.headline)
            Text("This is photo caption")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
    }
}

#Preview {
    MagnificationGestureBootCamp()
}
