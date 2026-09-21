//
//  TextEditorBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 13/03/26.
//

import SwiftUI

struct TextEditorBootCamp: View {
    @State var textEditorText:String = "This is starting text"
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $textEditorText)
                    .padding()
                Button(action: {
                    
                }, label: {
                    Text("Save".uppercased())
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10.0)
                        .foregroundColor(Color.white)
                        .padding()
                        .font(.headline)
                })
            }
            .navigationTitle("TextEditorBootCamp")
        }
    }
}

#Preview {
    TextEditorBootCamp()
}
