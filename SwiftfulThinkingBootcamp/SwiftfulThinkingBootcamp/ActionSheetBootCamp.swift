//
//  ActionSheetBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 02/03/26.
//

import SwiftUI

struct ActionSheetBootCamp: View {
    @State var showActionSheet = false
    var body: some View {
        Button("Click me") {
            showActionSheet.toggle()
        }.actionSheet(isPresented: $showActionSheet, content: {
            getActionSheet()
        })
    }
    
    func getActionSheet() -> ActionSheet {
//        return ActionSheet(title: Text("This is an action sheet"))
        let button1: ActionSheet.Button = .default(Text("Add"))
        let button2: ActionSheet.Button = .destructive(Text("Delete"))
        let button3: ActionSheet.Button = .cancel(Text("Cancel"))
        return ActionSheet(title: Text("This is the title"),
        message: Text("This is the message"),
        buttons: [button1, button2, button3])
    }
}


#Preview {
    ActionSheetBootCamp()
}
