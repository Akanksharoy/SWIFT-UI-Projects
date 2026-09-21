//
//  HashableBootCamp.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 07/07/26.
//

import SwiftUI

struct MyCustomModel:Hashable {
    let title:String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
}
struct HashableBootCamp: View {
    let data:[MyCustomModel] = [
        MyCustomModel(title: "ONE"),
        MyCustomModel(title: "TWO"),
        MyCustomModel(title: "THREE"),
        MyCustomModel(title: "FOUR")]

    var body: some View {
        VStack(spacing: 30) {
            ForEach(data, id: \.self) { item in
                Text(item.title)
                    .font(.headline)
            }
        }
    }
}

#Preview {
    HashableBootCamp()
}
