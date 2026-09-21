//
//  SoundsBootCamp.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 06/07/26.
//

import SwiftUI
import AVKit

class SoundManager {
    static let instance = SoundManager()
    
    private init() {
    
    }
}
struct SoundsBootCamp: View {
    
    var soundManager = SoundManager.instance
    var body: some View {
        VStack(spacing: 20) {
            Button("Play Sound 1") {
                
            }
            Button("Play Sound 1") {
                
            }
        }
    }
}

#Preview {
    SoundsBootCamp()
}
