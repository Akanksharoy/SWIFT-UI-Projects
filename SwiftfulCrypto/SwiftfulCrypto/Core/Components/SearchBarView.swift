//
//  SearchBarView.swift
//  SwiftfulCrypto
//
//  Created by Akanksha on 05/09/26.
//

import SwiftUI
import Combine


struct SearchBarView: View {
    
    @Binding var searchText:String

    var body: some View {
        HStack{
            Image(systemName:"magnifyingglass")
                .foregroundColor(searchText.isEmpty ? Color.theme.secondaryTextColor : Color.theme.accent)
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundColor(Color.theme.accent)
            
                .autocorrectionDisabled()
                .overlay (
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x:10)
                        .foregroundColor( Color.theme.accent)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    , alignment: .trailing
                        
                )
            
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color:Color.theme.accent.opacity(0.15), radius: 10, x: 0, y: 0)
        )
        .padding()
        
    }
}

struct SearchBarView_Previews: PreviewProvider {

    static var previews: some View {
        SearchBarView(searchText: .constant(""))
            
    }
}
