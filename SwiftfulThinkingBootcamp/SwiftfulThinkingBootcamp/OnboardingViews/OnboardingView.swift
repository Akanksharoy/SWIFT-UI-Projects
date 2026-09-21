//
//  OnboardingView.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 28/03/26.
//

import SwiftUI

struct OnboardingView: View {
    /*
     0 - welcome screen
     1 - add name
     2 - add age
     3 - add gender
     */
    @State var onboardingState:Int = 0
    @State var name:String = ""
    @State var age:Double = 50
    @State var gender:String = ""
    @State var alertTitle: String = ""
    @State var showAlert = false
    
    
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    var body: some View {
        ZStack {
            // content
            ZStack {
                switch onboardingState {
                case 0:
                    WelcomeSection
                        .transition(transition)
                case 1:
                    addNameSection
                        .transition(transition)
                case 2:
                    addAgeSection
                        .transition(transition)
                case 3:
                    addGenderSection
                        .transition(transition)
                default:
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(.green)
                }
            }
            // buttons
            VStack {
                Spacer()
                bottomButton
            }
            .padding(30)
        }
        .alert( isPresented: $showAlert, content: {
            return Alert(title: Text(alertTitle))
        })
    }
    
    
}

#Preview {
    OnboardingView()
        .background(Color.purple)
}

// MARK: Components
extension OnboardingView {
    private var bottomButton: some View {
        Text(onboardingState == 0 ? "SIGN UP" :
                onboardingState == 3 ? "FINISH": "NEXT")
        .font(.headline)
        .foregroundColor(.purple)
        .frame(height: 55)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .onTapGesture {
            handleNextButtonClick()
        }
    }
    
    private var WelcomeSection: some View {
        VStack(spacing: 40) {
            Spacer()
            Image(systemName: "heart.text.square.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.white)
            Text("Find your match")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .overlay(Capsule(style: .continuous).frame(height: 3).offset(y:5).foregroundColor(.white), alignment: .bottom)
            Text("This is the number one app for finding your match online! In this tutorial we are practising using appstorage and other swift ui techniques.")
                .fontWeight(.medium)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    private var addNameSection: some View {
        VStack(spacing: 40) {
            Spacer()
            Text("What's your name?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            TextField("Your name here...", text: $name)
                .font(.headline)
                .frame(height: 55)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)
            
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(30)
    }
    
    private var addAgeSection: some View {
        VStack(spacing: 40) {
            Spacer()
            Text("What's your age?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Text("\(String(format: "%0.f", age))")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Slider(value: $age, in:18...100, step: 1)
            
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(30)
    }
    
    private var addGenderSection: some View {
        VStack(spacing: 40) {
            Spacer()
            Text("What's your gender?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            //            Picker(selection: $gender,
            //                   label:
            //                    Text("Select a gender")
            //                .font(.headline)
            //                .foregroundColor(.purple)
            //                .frame(height: 55)
            //                .frame(maxWidth: .infinity)
            //                .background(Color.white)
            //                .cornerRadius(10),
            //                   content: {
            //                Text("1").tag("1")
            //                Text("2").tag("2")
            //
            //            })
            //            .pickerStyle(MenuPickerStyle())
            Picker("Select a gender", selection: $gender) {
                Text("Select").tag("")
                Text("Male").tag("Male")
                Text("Female").tag("Female")
                Text("Non-Binary").tag("Non-Binary")
            }
            .pickerStyle(.menu)
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(30)
    }
}

//MARK: FUNCTIONS
extension OnboardingView {
    
    func handleNextButtonClick() {
        //Check inputs
        switch onboardingState {
        case 1:
            guard name.count >= 3 else {
                showAlert(title: "Yor name must be at least three characters long")
                return
            }
        case 3:
            guard gender.count > 1 else {
                showAlert(title: "Please select a gender before moving forward")
                return
            }
        default:
            break
        }
        
        if onboardingState == 3{
            signIn()
        }
        else {
            withAnimation(.spring()){
                onboardingState+=1
            }
        }
    }
    
    func showAlert(title:String) {
        alertTitle = title
        showAlert.toggle()
    }
    
    func signIn(){
        currentUserAge = Int(age)
        currentUserName = name
        currentUserGender = gender
        withAnimation(.spring()){
            currentUserSignedIn = true

        }
    }
}
