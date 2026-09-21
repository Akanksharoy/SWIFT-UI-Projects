//
//  ToggleBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 13/03/26.
//

import SwiftUI

struct ToggleBootcamp: View {
    @State var toggleIsOn: Bool = false
    var body: some View {
        VStack {
            HStack{
                Text("Status:")
                Text(toggleIsOn ? "onlin" : "offline")
            }
            Toggle(isOn: $toggleIsOn, label: {
                Text("Change Status")
            })
            .toggleStyle(SwitchToggleStyle(tint: Color.cyan))
        }
    }
}

#Preview {
    ToggleBootcamp()
}
