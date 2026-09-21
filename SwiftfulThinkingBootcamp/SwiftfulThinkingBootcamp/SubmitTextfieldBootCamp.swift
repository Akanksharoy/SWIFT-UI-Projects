//
//  SubmitTextfieldBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 02/06/26.
//

import SwiftUI

struct SubmitTextfieldBootCamp: View {
    @State private var text = ""
    var body: some View {
        VStack(spacing: 16) {
            TextField("Placeholder...", text: $text)
                .textFieldStyle(.roundedBorder)
                .submitLabel(.done)
                .onSubmit {
                    // Handle submit action here
                    print("Submitted: \(text)")
                }

            Text("You typed: \(text)")
        }
        .padding()
    }
}

#Preview {
    SubmitTextfieldBootCamp()
}
