//
//  StacksBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 15/01/26.
//

import SwiftUI

struct StacksBootcamp: View {
    // vstacks - vertical
    // hstacks - horizontal
    // zstacks - zindex(back to front)
    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            Rectangle()
//                .fill(Color.red)
//                .frame(width: 140, height: 100)
//            Rectangle()
//                .fill(Color.blue)
//                .frame(width: 100, height: 100)
//            Rectangle()
//                .fill(Color.green)
//                .frame(width: 100, height: 100)
//        }
//        HStack(alignment: .top, spacing: 0) {
//            Rectangle()
//                .fill(Color.red)
//                .frame(width: 140, height: 100)
//            Rectangle()
//                .fill(Color.blue)
//                .frame(width: 100, height: 100)
//            Rectangle()
//                .fill(Color.green)
//                .frame(width: 100, height: 100)
//        }
//        ZStack() {
//            Rectangle()
//                .fill(Color.red)
//                .frame(width: 150, height: 150)
//            Rectangle()
//                .fill(Color.blue)
//                .frame(width: 120, height: 120)
//            Rectangle()
//                .fill(Color.green)
//                .frame(width: 100, height: 100)
//        }
        //Zstack acts like a background
        VStack(spacing: 50) {
            ZStack {
                Circle()
                    .fill(Color.black)
                    .frame(width: 100, height: 100)
                Text("1")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
            }
            Text("1")
                .font(.largeTitle)
                .foregroundColor(Color.white)
                .background(
                    Circle()
                        .fill(Color.black)
                        .frame(width: 100, height: 100)
                    
                )
        }
    }
}

#Preview {
    StacksBootcamp()
}
