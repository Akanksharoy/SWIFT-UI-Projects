//
//  SafeAreaBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 17/01/26.
//

import SwiftUI

struct SafeAreaBootCamp: View {
    var body: some View {
//        ZStack {
//            Color.blue
//                .edgesIgnoringSafeArea(.all)
//            VStack {
//                Text("Hello World")
//                Spacer()
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color.red)
//        }
//        
//        ZStack {
//            Color.blue
//                .edgesIgnoringSafeArea(.all)
//            ScrollView{
//                Text("Some blah blah")
//                    .font(.largeTitle)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding()
//                ForEach(0..<10){
//                    index in
//                    RoundedRectangle(cornerRadius: 25)
//                        .fill(Color.white)
//                        .frame(height: 200)
//                        .shadow(radius: 10)
//                        .padding()
//                }
//            }
//        }
        

            ScrollView{
                Text("Some blah blah")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                ForEach(0..<10){
                    index in
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .frame(height: 200)
                        .shadow(radius: 10)
                        .padding()
                }
            }
            .background(
                Color.blue
//                    .edgesIgnoringSafeArea(.all) /old/ 
                    .ignoresSafeArea()
            )
        
        
       
            
           
    }
}

#Preview {
    SafeAreaBootCamp()
}
