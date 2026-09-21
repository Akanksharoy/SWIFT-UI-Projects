//
//  PopOverBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 22/01/26.
//

import SwiftUI

struct PopOverBootCamp: View {
    @State var showSheet = false
    var body: some View {
        ZStack {
            Color.orange
                .edgesIgnoringSafeArea(.all)
            VStack {
                Button("BUTTON"){
                    showSheet.toggle()
                }
                .font(.largeTitle)
                
                Spacer()
            }
            //METHOD 1
//            .sheet(isPresented: $showSheet, content: {
//                NewScreen()
//            })
            //METHOD 2
            if showSheet {
                NewScreen()
                    .transition(.move(edge: .bottom))
                    .animation(.spring)
            }
        }
    }
}
struct NewScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Color.purple
                .edgesIgnoringSafeArea(.all)
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label:{
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            })
            
        }
    }
}

#Preview {
    PopOverBootCamp()
}
