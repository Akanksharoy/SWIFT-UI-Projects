//
//  IntroView.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 21/03/26.
//

import SwiftUI

struct IntroView: View {
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false

    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.blue, Color.teal]),
                center: .topLeading,
                startRadius: 5,
                endRadius: UIScreen.main.bounds.height)
            .ignoresSafeArea()
            
            if currentUserSignedIn {
                ProfileView()
            }
            else {
                OnboardingView()
            }
        }
    }
}

#Preview {
    IntroView()
}
