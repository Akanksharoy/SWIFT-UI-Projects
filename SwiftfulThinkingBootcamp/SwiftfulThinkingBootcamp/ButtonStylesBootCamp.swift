//
//  ButtonStylesBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 22/05/26.
//

import SwiftUI

struct ButtonStylesBootCamp: View {
    var body: some View {
        VStack {
            // In below button control size gets applied to the label
            Button {
                
            } label: {
                Text("Button Title")
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)

            }
            .buttonStyle(.borderedProminent)
            .controlSize(.extraLarge)
            .buttonBorderShape(.roundedRectangle(radius: 20))
            
            
            Button("Button Title"){
                
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
//            .buttonStyle(.plain)
            .buttonStyle(.borderedProminent)
            .controlSize(.extraLarge)
            
            Button("Button Title"){
                
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
//            .buttonStyle(.bordered)
            .buttonStyle(.borderedProminent)
            .controlSize(.large)

            
            Button("Button Title"){
                
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
//            .buttonStyle(.borderedProminent)
            .buttonStyle(.borderedProminent)
            .controlSize(.regular)

            Button("Button Title"){
                
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
//            .buttonStyle(.borderless)
            .buttonStyle(.borderedProminent)
            .controlSize(.small)

            
        }
        .padding()
    }
    
 
}

#Preview {
    ButtonStylesBootCamp()
}
