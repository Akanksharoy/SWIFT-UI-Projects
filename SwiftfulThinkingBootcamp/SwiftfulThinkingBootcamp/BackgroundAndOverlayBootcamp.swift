//
//  BackgroundAndOverlayBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 15/01/26.
//

import SwiftUI

struct BackgroundAndOverlayBootcamp: View {
    var body: some View {
        //        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        //            .frame(width: 100, height: 100)
        //            .background(
        //                Color.red
        //                LinearGradient(colors: [Color.red, Color.blue], startPoint: .leading, endPoint: .trailing)
        //                Circle()
        //                    .fill(Color.blue)
        //            )
        //            .frame(width: 120, height: 120, alignment: .center)
        //            .background(
        //                Circle().fill(Color.red)
        //            )
        
        //            .background(
        //
        //                Circle()
        //                    .fill(Color.blue)
        //                    .frame(width: 100, height: 100)
        //            )
        //            .background(
        //                Circle().fill(Color.red)
        //                    .frame(width: 120, height: 120, alignment: .center)
        //            )
        //Overlays
//        Circle()
//            .fill(Color.pink)
//            .frame(width: 100, height: 100)
//            .overlay(
//                Text("1")
//                    .font(.largeTitle)
//                    .foregroundColor(Color.white)
//            )
//            .background(
//                Circle()
//                    .fill(Color.purple)
//                    .frame(width: 110, height: 110)
//            )
        //alignment example
        Rectangle()
            .frame(width: 100, height: 100)
            .overlay(
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 50, height: 50),alignment: .leading
            )
            .background(
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 200, height: 200)
                , alignment: .topLeading
            )
    }
}

#Preview {
    BackgroundAndOverlayBootcamp()
}
