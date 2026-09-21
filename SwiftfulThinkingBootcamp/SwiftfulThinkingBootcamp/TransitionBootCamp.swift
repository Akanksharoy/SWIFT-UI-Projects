//
//  TransitionBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 21/01/26.
//

import SwiftUI

struct TransitionBootCamp: View {
    @State var showView: Bool = true
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Button("Button"){
                    showView.toggle()
                }
                Spacer()
            }
            if (showView){
                RoundedRectangle(cornerRadius: 25)
                    .frame(height: UIScreen.main.bounds.height*0.5)
//                    .transition(.slide)
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .bottom)))
                    .animation(.easeInOut)
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    TransitionBootCamp()
}
