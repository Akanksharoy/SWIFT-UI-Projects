//
//  FoorEachBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 16/01/26.
//

import SwiftUI

struct FoorEachBootCamp: View {
    let dataString:[String] = ["hi", "hello", "hello everyone"]
    
    var body: some View {
        VStack{
//            ForEach(0..<10){
//                index in
//                HStack {
//                    Circle()
//                        .frame(width: 20, height: 20)
//                    Text("Index is \(index)")
//                }
//            }
            ForEach(dataString.indices){
                index in
                Text("\(dataString[index]): \(index)")
            }
           
        }
    }
}

#Preview {
    FoorEachBootCamp()
}
