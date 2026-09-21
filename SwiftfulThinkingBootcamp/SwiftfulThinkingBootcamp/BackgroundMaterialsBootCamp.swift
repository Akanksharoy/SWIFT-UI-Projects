//
//  BackgroundMaterialsBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 21/05/26.
//

import SwiftUI

struct BackgroundMaterialsBootCamp: View {
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("Hi")
            }
            .frame(height: 350)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(30)
        }
        .ignoresSafeArea()
        .background(
            Image(systemName: "heart.fill")
        )
    }
}

#Preview {
    BackgroundMaterialsBootCamp()
}
