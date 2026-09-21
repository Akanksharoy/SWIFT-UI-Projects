//
//  AccessibilityVoiceOverBootCamp.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 22/08/26.
//

import SwiftUI

struct AccessibilityVoiceOverBootCamp: View {
    @State var isActive: Bool = false
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    Toggle("Volume", isOn: $isActive)
                    HStack {
                        Text("Volume")
                        Spacer()
                        Text(isActive ? "ON" : "OFF")
                            .accessibilityHidden(true)
                    }
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        isActive.toggle()
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityValue(isActive ? "is Off" : "is On")
                    .accessibilityAddTraits(.isButton)
                    .accessibilityHint("Double tap to toggle settings.")
                } header: {
                    Text("PREFERENCES")
                }
                
                Section {
                    Button("Favourites") {
                        
                    }
                    Button {
                        
                    } label: {
                        Image(systemName: "heart.fill")
                    }
                    Text("Favourites")
                        .accessibilityAddTraits(.isButton)
                        .onTapGesture {
                            
                        }

                } header: {
                    Text("Application")
                }
            }
        }
    }
}

#Preview {
    AccessibilityVoiceOverBootCamp()
}
