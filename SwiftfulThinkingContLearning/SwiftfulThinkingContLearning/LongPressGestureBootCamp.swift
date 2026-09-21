//
//  LongPressGestureBootCamp.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 03/07/26.
//

import SwiftUI

struct LongPressGestureBootCamp: View {
    @State var isComplete:Bool = false
    @State var isSuccess:Bool = false
    
    var body: some View {
        
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(maxWidth: isComplete ? .infinity : 10)
                .frame(height: 55)
                .frame(maxWidth: .infinity,alignment: .leading)
                .background(Color.gray)
            
            HStack {
                Text("CLICK HERE")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 1.0){
                        (isPressing) in
                        
                        //start of press to min duration
                        if isPressing {
                            withAnimation(.easeInOut(duration: 1.0)){
                                isComplete.toggle()
                            }
                        }
                    } perform: {
                        //at the min duartion
                        withAnimation(.easeInOut) {
                            isSuccess.toggle()
                        }
                        
                    }
                Text("RESET")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
            }
            
            
            
        }
//        Text(isComplete ? "COMPLETED" : "NOT COMPLETED")
//            .padding()
//            .padding(.horizontal)
//            .background(isComplete ? Color.green : Color.gray)
//            .cornerRadius(10)
//            .onLongPressGesture(minimumDuration: 1.0){
//                isComplete.toggle()
//            }
    }
}

#Preview {
    LongPressGestureBootCamp()
}
