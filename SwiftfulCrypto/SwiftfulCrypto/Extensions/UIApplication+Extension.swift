//
//  U.swift
//  SwiftfulCrypto
//
//  Created by Akanksha on 07/09/26.
//
import SwiftUI
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
