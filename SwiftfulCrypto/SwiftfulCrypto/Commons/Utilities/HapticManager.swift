//
//  HapticManager.swift
//  SwiftfulCrypto
//
//  Created by Akanksha on 15/09/26.
//
 import SwiftUI
class HapticManager {
    static let generator = UINotificationFeedbackGenerator()
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        generator.notificationOccurred(type)
    }
    
}
