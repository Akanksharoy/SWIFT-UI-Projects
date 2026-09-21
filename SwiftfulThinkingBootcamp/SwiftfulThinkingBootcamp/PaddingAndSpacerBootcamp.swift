//
//  PaddingAndSpacerBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 15/01/26.
//

import SwiftUI

struct PaddingAndSpacerBootcamp: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    //            .padding() // by default all sides
    //            .padding(.horizontal, 10)
    //            .padding(.vertical, 20)
    //            .background(Color.blue)
            
//                .font(.largeTitle)
//                .fontWeight(.semibold)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.leading, 20)
//                .background(
//                    Color.red
//                )
            Text("This is a description of what we will do in this bootcamp. It is multiple lines long.")
        }
        .padding()
        .background(
            Color.white
                .shadow(color:Color.black.opacity(0.6), radius: 10, x: 0, y: 10)
        )
        .padding(.horizontal, 10)

        
    }
}

#Preview {
    PaddingAndSpacerBootcamp()
}
