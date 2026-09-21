//
//  FocusStateBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 26/05/26.
//

import SwiftUI

struct FocusStateBootCamp: View {
    
    enum OnboardingField: Hashable {
        case username
        
        case password
    }
    
    @FocusState var usernameInFocus:Bool
    @FocusState var passwordInFocus:Bool
    @FocusState private var fieldInFocus:OnboardingField?
    @State private var userName = ""
    @State private var password = ""
    
    
    var body: some View {
        VStack {
            TextField("Enter your name", text: $userName)
//                .focused($usernameInFocus)
                .focused($fieldInFocus, equals: .username)
                .padding()
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.gray.brightness(0.3))
                .cornerRadius(20)
                .padding()
            TextField("Add your password here", text: $password)
//                .focused($passwordInFocus)
                .focused($fieldInFocus, equals: .password)
                .padding()
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.gray.brightness(0.3))
                .cornerRadius(20)
                .padding()
            
            Button("SIGN UP") {
                let usernameIsValid = !userName.isEmpty
                let passwordIsValid = !password.isEmpty
                
                if usernameIsValid && passwordIsValid {
                    print("Sign up")
                } else if usernameIsValid {
                    fieldInFocus = .password
//                    usernameInFocus = false
//                    passwordInFocus = true
                    
                }
                else {
                    fieldInFocus = .username
//                    usernameInFocus = true
//                    passwordInFocus = false
                }
            }
            
//            Button("Toggle focus state")
//            {
//                withAnimation(.easeInOut(duration: 0.5))
//                {
//                    usernameInFocus.toggle()
//                }
//            }

        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                usernameInFocus.toggle()
            }
        }
    }
}

#Preview {
    FocusStateBootCamp()
}
