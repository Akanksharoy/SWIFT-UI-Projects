//
//  CodablevBootCamp.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 22/07/26.
//

import SwiftUI
import Combine

struct Customer: Codable {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
}


class CustomerViewModel: ObservableObject {
    @Published var customer: Customer? = nil
    
    init() {
        getData()
    }
    
    func getData() {
        guard let data = getJsonData() else {
            return
        }
        do {
            let decoded = try JSONDecoder().decode(Customer.self, from: data)
            DispatchQueue.main.async {
                self.customer = decoded
            }
        } catch {
            print("Decoding error:", error)
        }
    }
    
    func getJsonData() -> Data? {
        
        let dictionary:[String:Any] = ["id":"1334", "name":"Joe", "points": 100, "isPremium": true]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        return jsonData
        
        
    }
}
struct CodablevBootCamp: View {
    
    @StateObject var viewModel: CustomerViewModel = CustomerViewModel()
    var body: some View {
          VStack(spacing: 20) {
              if let customer = viewModel.customer {
                  Text(customer.id)
                  Text(customer.name)
                  Text("\(customer.points)")
                  Text(customer.isPremium.description)
              }
          }
      }
}

#Preview {
    CodablevBootCamp()
}
