//
//  AppStorageBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 20/03/26.
//

import SwiftUI

struct AppStorageBootcamp: View {
    @AppStorage("name") var name: String?
    var body: some View {
        VStack(spacing: 20)
        {
            Text(name ?? "")
            Button("Save".uppercased()){
                name = "Nick"
                UserDefaults.standard.set(name, forKey: "name")
            }
        }
        .onAppear{
            name = UserDefaults.standard.string(forKey: "name")
        }
    }
}

#Preview {
    AppStorageBootcamp()
}
