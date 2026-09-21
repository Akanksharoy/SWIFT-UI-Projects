//
//  GridBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 17/01/26.
//

import SwiftUI

struct GridBootCamp: View {
    //    let columns: [GridItem] = [
    //        GridItem(.fixed(50), spacing: nil, alignment: nil),
    //        GridItem(.fixed(50), spacing: nil, alignment: nil),
    //        GridItem(.fixed(50), spacing: nil, alignment: nil),
    //        GridItem(.fixed(50), spacing: nil, alignment: nil)
    //    ]
    //    var body: some View {
    //        LazyVGrid(columns: columns){
    //            ForEach(0..<50) {
    //                index in
    //                Rectangle().frame(height: 50)
    //            }
    //
    //        }
    //    }
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil)
    ]
    var body: some View {
        //            ScrollView {
        //                Rectangle()
        //                    .fill(Color.white)
        //                    .frame(height: 300)
        //                LazyVGrid(columns: columns){
        //                    ForEach(0..<50) {
        //                        index in
        //                        Rectangle().frame(height: 150)
        //                    }
        //
        //                }
        //            }
        ScrollView{
            LazyVGrid(columns: columns,
                      alignment: .center,
                      spacing: nil,
                      pinnedViews: [.sectionHeaders],
                      content: {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: .infinity)
                Section(
                    header: Text("Section 1")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                ){
                    ForEach(0..<50) {
                        index in
                        Rectangle().frame(height: 150)
                    }
                }
                Section(
                    header: Text("Section 2")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                ){
                    ForEach(0..<50) {
                        index in
                        Rectangle().frame(height: 150)
                    }
                }
                
                
            })
        }
        
    }
}

#Preview {
    GridBootCamp()
}
