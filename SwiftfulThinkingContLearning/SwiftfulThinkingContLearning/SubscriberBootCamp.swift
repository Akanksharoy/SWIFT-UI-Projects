//
//  SubscriberBootCamp.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 12/08/26.
//

import SwiftUI
import Combine
class SubscriberBootCampViewModel: ObservableObject {
    @Published var count:Int = 0
    @Published var textFieldText = ""
    @Published var textIsValid: Bool = false
    @Published var showButton: Bool = false
    var cancellables = Set<AnyCancellable>()
    
    init(){
        setuptimer()
        addTextFieldSubscriber()
    }
    func setuptimer() {
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.count += 1
                if self.count >= 10 {
                    self.cancellables.forEach { $0.cancel() }
                }
            })
            .store(in: &cancellables)
    }
    
    func addTextFieldSubscriber(){
        $textFieldText
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .map{
                (text:String) -> Bool  in
                if text.count > 3 {
                    return true
                }
                return false
                
            }
            .assign(to: \.textIsValid, on: self)
            .store(in: &cancellables)
        
    }
    
    func addbuttonsubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink{[weak self] (isValid, count) in
                guard let self = self else {
                    return
                }
                if isValid && count >= 0 {
                    self.showButton = true
                }
                else {
                    self.showButton = false
                }
                
            }
            .store(in: &cancellables)
    }
    
}
struct SubscriberBootCamp: View {
    @StateObject var viewModel = SubscriberBootCampViewModel()
    var body: some View {
        VStack {
            Text("\(viewModel.count)")
            TextField("Type something here...", text: $viewModel.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding()
                .overlay(alignment: .trailing) {
                    ZStack() {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(viewModel.textFieldText.count < 1 ? 0 : viewModel.textIsValid ? 0 : 1)
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity( viewModel.textIsValid ? 1 : 0)
                    }
                    
                    .font(.title)
                    .padding(.trailing)
                }
            Button {
                
            } label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .opacity(viewModel.showButton ? 1 : 0.5)
                    .padding(.horizontal)
            }
            .disabled(!viewModel.showButton)

            
            
        }
        
    }
}

#Preview {
    SubscriberBootCamp()
}
