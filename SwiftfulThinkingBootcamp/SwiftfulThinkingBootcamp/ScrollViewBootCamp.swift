//
//  ScrollViewBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 16/01/26.
//

import SwiftUI

struct ScrollViewBootCamp: View {
    var body: some View {
        //        ScrollView(showsIndicators: false){
        //            VStack {
        //                ForEach(0..<50){
        //                    index in
        //                    Rectangle()
        //                        .fill(Color.blue)
        //                        .frame(height: 300)
        //
        //                }
        //
        //            }
        //        }
        ScrollView(){
            VStack{
                ForEach(0..<10){
                    index in
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(){
                            ForEach(0..<20){
                                index in
                                Rectangle()
                                    .fill(Color.white)
                                    .cornerRadius(20)
                                    .frame(width: 200, height: 200)
                                    .shadow(radius: 10)
                                    .padding()
                            }
                        }
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ScrollViewBootCamp()
}
