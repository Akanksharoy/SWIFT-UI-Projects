//
//  AccessibilityColorsBootCamp.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 21/08/26.
//

import SwiftUI

struct AccessibilityColorsBootCamp: View {
    @Environment(\.accessibilityReduceTransparency) var reducedTransparency : Bool
    var body: some View {
        NavigationStack {
            VStack {
                Button("Button 1") {
                    
                }
                .foregroundColor(.primary)
                .buttonStyle(.borderedProminent)
                Button("Button 2") {
                    
                }
                .foregroundColor(.primary)
                .buttonStyle(.borderedProminent)
                .tint(.orange)
                Button("Button 3") {
                    
                }
                .foregroundColor(.white)
                .buttonStyle(.borderedProminent)
                .tint(.green)
                Button("Button 4") {
                    
                }
                .foregroundColor(.green)
                .buttonStyle(.borderedProminent)
                .tint(.purple)
                
                
            }
            .font(.largeTitle)
//            .navigationTitle("Hi")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(reducedTransparency ? Color.black : Color.black.opacity(0.5))
        }
       
    }
}

#Preview {
    AccessibilityColorsBootCamp()
}
