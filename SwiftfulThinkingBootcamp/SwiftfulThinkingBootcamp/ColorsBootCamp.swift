//
//  ColorsBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 14/01/26.
//

import SwiftUI

struct ColorsBootCamp: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(
//                Color.red
//             Color(UIColor.secondarySystemBackground)
                Color("CustomColor")
            )
            .frame(width: 300, height: 500)
//            .shadow(radius: 10)
            .shadow(color: Color("CustomColor").opacity(0.9), radius: 30, x: -20, y: 20)
    }
}

#Preview {
    ColorsBootCamp()
}
