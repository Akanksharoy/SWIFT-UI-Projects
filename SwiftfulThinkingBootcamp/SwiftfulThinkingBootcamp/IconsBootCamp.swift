//
//  IconsBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 14/01/26.
//

import SwiftUI

struct IconsBootCamp: View {
    var body: some View {
        Image(systemName: "heart.fill")
            .resizable()
//            .font(.largeTitle)\
//            .aspectRatio(contentMode: .fit)
            .scaledToFill()
            .font(.system(size: 50)) //does not scale
            .foregroundColor(.green)
            .frame(width: 200, height: 200)
            .clipped()
        
    }
}

#Preview {
    IconsBootCamp()
}
