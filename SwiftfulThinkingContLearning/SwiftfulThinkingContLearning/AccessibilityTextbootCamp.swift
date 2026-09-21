//
//  AccessibilityTextbootCamp.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 20/08/26.
//

import SwiftUI

struct AccessibilityTextbootCamp: View {
    @Environment(\.sizeCategory) var sizeCategory
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<10) {
                    index in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "heart.fill")
                            Text("Welcome to my app")
                        }
                        .font(.title)
                        Text("This seems longer text that expands to multiple lines.")
                            .font(.subheadline)
                            .lineLimit(3)
                            .minimumScaleFactor(sizeCategory.customScaleFactor)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Hellow World")
        }
    }
}

extension ContentSizeCategory {
    var customScaleFactor:CGFloat {
        switch self {
        case .extraSmall, .small, .medium:
            return 1
        case .large, .extraLarge, .extraExtraLarge:
            return 0.8
        default:
            return 0.6
        }
    }
}

#Preview {
    AccessibilityTextbootCamp()
}
