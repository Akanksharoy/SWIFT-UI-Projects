//
//  ScrollViewReaderBootcamp.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 04/07/26.
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {
    @State var scrollToIndex: Int = 0
    @State var textfieldText: String = ""
    var body: some View {
        VStack {
            TextField("Enter a # here...", text: $textfieldText)
                .frame(height: 55)
                .border(Color.gray, width: 1)
                .padding()
                .keyboardType(.numberPad)
            Button("SCROLL NOW") {
                
                withAnimation(.spring()){
                    if let index = Int(textfieldText) {
                        scrollToIndex = index
                    }
                }
            }
            
            ScrollView {
                ScrollViewReader { proxy in
                    
                    ForEach(0..<50){
                        index in
                        Text("This is item #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex, perform: {
                        value in
                        withAnimation(.spring()){
                            proxy.scrollTo(value, anchor: nil)
                        }
                    })
                }
                
            }
        }
        
    }
}

#Preview {
    ScrollViewReaderBootcamp()
}
