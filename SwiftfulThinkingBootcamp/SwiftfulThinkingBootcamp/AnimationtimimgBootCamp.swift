//
//  AnimationtimimgBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 21/01/26.
//

import SwiftUI

struct AnimationtimimgBootCamp: View {
    @State var isAnimating:Bool = false
    var timing:Double = 10
    
    var body: some View {
        VStack {
            Button("Button") {
                isAnimating.toggle()
            }
            RoundedRectangle(cornerRadius: 25)
                .frame(width: isAnimating ? 350 : 100,height: 50)
                .animation(Animation.linear(duration: timing))
            RoundedRectangle(cornerRadius: 25)
                .frame(width: isAnimating ? 350 : 100,height: 50)
                .animation(Animation.easeIn(duration: timing))
            RoundedRectangle(cornerRadius: 25)
                .frame(width: isAnimating ? 350 : 100,height: 50)
                .animation(Animation.easeInOut(duration: timing))
            RoundedRectangle(cornerRadius: 25)
                .frame(width: isAnimating ? 350 : 100,height: 50)
                .animation(Animation.easeOut(duration: timing))
        }

    }
}

#Preview {
    AnimationtimimgBootCamp()
}
