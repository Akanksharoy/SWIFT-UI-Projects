//
//  TernaryBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 20/01/26.
//

import SwiftUI

struct TernaryBootCamp: View {
    @State var isStattingState:Bool = false
    
    var body: some View {
        VStack {
            Button("Button \(isStattingState.description)"){
                isStattingState.toggle()
            }
            
            RoundedRectangle(cornerRadius: 25)
                .fill(isStattingState ? Color.red : Color.blue)
                .frame(width: 200, height: 100)
        }
    }
}

#Preview {
    TernaryBootCamp()
}
