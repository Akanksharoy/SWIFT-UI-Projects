//
//  SpacerBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 15/01/26.
//

import SwiftUI

struct SpacerBootcamp: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "xmark")
                Spacer()
                Image(systemName: "gear")
            }
            .font(.largeTitle)
            .padding()
        }
        
    }
}

#Preview {
    SpacerBootcamp()
}
