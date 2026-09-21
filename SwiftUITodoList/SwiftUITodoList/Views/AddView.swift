//
//  AddView.swift
//  SwiftUITodoList
//
//  Created by Akanksha on 03/06/26.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel

    @State var textFieldText: String = ""
    @State private var showValidationError: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type something here..", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 60)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .onChange(of: textFieldText) { newValue in
                        if showValidationError && newValue.count >= 3 {
                            showValidationError = false
                        }
                    }
                
                if showValidationError {
                    Text("Please enter the item")
                        .foregroundColor(.red)
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Button(action: saveButtonPressed,label: {
                    Text("Save".uppercased())
                        .foregroundColor(Color.white)
                        .font(.headline)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(20)
                    
                    
                })
            }
            .padding(14)
            
        }
        .navigationTitle("Add an item")
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addItem(title: textFieldText)
            showValidationError = false
            presentationMode.wrappedValue.dismiss()
        } else {
            showValidationError = true
        }
    }
    
    func textIsAppropriate()->Bool{
        if textFieldText.count < 3 {
            return false
        }
        return true
    }
    
}

#Preview {
    NavigationView{
        AddView()
    }
}
