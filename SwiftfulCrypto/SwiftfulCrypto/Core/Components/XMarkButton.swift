//
//  XMarkButton.swift
//  SwiftfulCrypto
//
//  Created by Akanksha on 10/09/26.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button(
            action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.headline)
            })
    }
}

#Preview {
    XMarkButton()
}
