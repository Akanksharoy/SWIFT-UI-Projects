//
//  ArraysBootCamp.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 07/07/26.
//

import SwiftUI
import Combine

struct User:Identifiable {
    let id = UUID().uuidString
    let name: String
    let point:Int
    let isVerified:Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var userArray: [User] = []
    @Published var filteredArray: [User] = []
    @Published var mappedArray:[String] = []
    init(){
        getUsers()
        updateFilteredArray()
    }
    
    func getUsers(){
        let user1 = User(name: "Akanksha", point: 10, isVerified: true)
        let user2 = User(name: "Aman", point: 8, isVerified: true)
        let user3 = User(name: "Chris", point: 6, isVerified: true)
        let user4 = User(name: "Joe", point: 12, isVerified: false)
        let user5 = User(name: "Ryan", point: 1, isVerified: true)
        self.userArray.append(contentsOf: [user1, user2, user3, user4, user5])
    }
    func updateFilteredArray(){
        //sort
        //filter
        //map
        
//        filteredArray = userArray.sorted{(user1, user2) -> Bool in
//            return user1.point < user2.point
//        }
//        filteredArray = userArray.filter({ user in
//            return user.name.contains("a")
//        })
        
        
        
    }
}

struct ArraysBootCamp: View {
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        VStack( spacing:20) {
            ForEach(vm.filteredArray){ user in
                VStack(alignment:.leading){
                    Text(user.name)
                        .font(.headline)
                    HStack{
                        Text("Points: \(user.point)")
                        Spacer()
                        if (user.isVerified) {
                            Image(systemName: "flame.fill")
                        }
                    }
                    
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal)

            }
        }
    }
}

#Preview {
    ArraysBootCamp()
}
