//
//  FrameBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 15/01/26.
//

import SwiftUI

struct FrameBootCamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .background(Color.green)
            .frame(height: 100)
            .background(Color.orange)
//            .frame(width: 200, height: 100, alignment: .center)
//            .frame(minWidth: 10, maxWidth: .infinity, alignment: .leading)
//            .background(Color.red)
    }
}

#Preview {
    FrameBootCamp()
}
