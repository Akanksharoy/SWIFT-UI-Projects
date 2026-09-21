//
//  GeometryReaderBootCamp.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 05/07/26.
//

import SwiftUI

struct GeometryReaderBootCamp: View {
    var body: some View {
        HStack(spacing:0) {
            Rectangle()
                .fill(Color.red)
            Rectangle()
                .fill(Color.blue)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    GeometryReaderBootCamp()
}
