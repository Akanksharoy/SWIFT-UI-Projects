//
//  TextBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 12/01/26.
//

import SwiftUI

struct TextBootcamp: View {
    var body: some View {
        Text("hbjhbf wvwvwr wewe ewwe werfwer efwef erfwerfg wewerew ewrfwef errgew egge fwerw rwfwe wfwef efw wef fww fwre wfwfwfw fw wfwf")
//            .font(.title)
//            .fontWeight(.bold)
//            .bold()
//            .underline()
//            .underline(true, color: .blue)
//            .strikethrough(true, color: .red)
//            .font(.system(size: 24, weight: .bold, design: .monospaced)) - The problem is this will not resize according to phone settings
            .multilineTextAlignment(.leading)
            .foregroundColor(.red)
            .minimumScaleFactor(0.1)
//            .kerning(0.1)
            
        
    }
}

#Preview {
    TextBootcamp()
}
