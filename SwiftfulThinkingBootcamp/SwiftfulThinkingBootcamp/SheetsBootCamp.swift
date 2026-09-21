//
//  SheetsBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 21/01/26.
//

import SwiftUI

struct SheetsBootCamp: View {
    @State var isSheetPresented: Bool = false
    var body: some View {
        ZStack {
            Color.green
                .edgesIgnoringSafeArea(.all)
            Button(action: {
                isSheetPresented.toggle()
            },
                   label: {
                Text("Button")
                    .padding(20)
                    .background(Color.white)
                    .font(.headline)
                    .foregroundColor(Color.green)
                
            })
            
        }
        .fullScreenCover(isPresented: $isSheetPresented, content: {
            //cannot be dragged down like sheets
            SecondView()
        })
//        .sheet(isPresented: $isSheetPresented, content: {
        //DO NOT ADD CONDITIONAL LOGIC HERE 
//            SecondView()
//        })
        
    }
}

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.red
                .edgesIgnoringSafeArea(.all)
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            },
                   label: {
                Image(systemName: "xmark")
                    .padding(20)
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                
            })
            
        }

    }
}

#Preview {
    SheetsBootCamp()
//    SecondView()
}
