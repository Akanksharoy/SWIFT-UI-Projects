//
//  IfLetGuardBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 15/03/26.
//

import SwiftUI

struct IfLetGuardBootcamp: View {
    @State var displayText: String = ""
    @State var isLoading: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Here we are practising safe coding")
                Text(displayText)
                    .font(.largeTitle)
                if isLoading {
                    ProgressView()
                }
                Spacer()
                
            }
            .navigationTitle("Safe coding")
            .onAppear{
                loadData()
            }
        }
    }
    func loadData() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now()+3){
            displayText = "This is a new data"
            isLoading = false
        }
    }
}

#Preview {
    IfLetGuardBootcamp()
}
