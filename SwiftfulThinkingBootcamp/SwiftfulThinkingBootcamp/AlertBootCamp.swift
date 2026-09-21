//
//  AlertBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 02/03/26.
//
import SwiftUI
struct AlertBootCamp: View {
    @State var showAlert = false
    @State var backgroundColor = Color.yellow
    @State var alertMessage = ""
    @State var alertTitle = ""
    enum MyAlerts {
        case success
        case failure
    }
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                Button("Button 1"){
                    alertTitle = "Error uploading video"
                    alertMessage = "The video could not be uploaded. Please try again."
                    showAlert.toggle()

                }
                Button("Button 2"){
                    alertTitle = "Successfully uploaded video"
                    alertMessage = "The video is uploaded."
                    showAlert.toggle()

                }
                
            }.alert(isPresented: $showAlert, content: {
                getAlert()
            })
        }
    }
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//        return Alert(title: Text("this is the title"),
//                     message: Text("this is the message"),
//                     primaryButton: .destructive(Text("DELETE"), action: {
//            backgroundColor = .red
//        }),
//                     secondaryButton: .cancel())
        
    }
}

#Preview {
    AlertBootCamp()
}

