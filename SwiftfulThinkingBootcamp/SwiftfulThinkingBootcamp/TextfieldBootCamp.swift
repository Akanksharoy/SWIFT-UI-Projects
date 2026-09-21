//
//  TextfieldBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 03/03/26.
//

import SwiftUI

struct TextfieldBootCamp: View {
    @State var textFieldText: String = ""
    var body: some View {
        NavigationView {
            VStack {
                TextField("Type something here..", text: $textFieldText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .foregroundColor(Color.red)
                
                Button(action: {
                    
                }, label: {
                    Text("Save".uppercased())
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .font(.headline)
                })
                Spacer()
            }
            .navigationTitle("Textfield")
        }
        
    }
}

#Preview {
    TextfieldBootCamp()
}
