//
//  AsyncImageBootCamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Akanksha on 21/05/26.
//

import SwiftUI

struct AsyncImageBootCamp: View {
    let url = URL(string: "https://picsum.photos/200")
    var body: some View {
        AsyncImage(url: url) {
            phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let returnedImage):
                returnedImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(20)
            case .failure(let error):
                Image(systemName: "questionmark")
                    .font(.headline)
            default:
                Image(systemName: "questionmark")
                    .font(.headline)
            }
        }
        //        AsyncImage(url: url, content: {
        //            returnedImage in
        //            returnedImage
        //                .resizable()
        //                .scaledToFit()
        //                .frame(width: 100, height: 100)
        //                .cornerRadius(20)
        //        }, placeholder: {
        //            ProgressView()
        //        })
        
    }
}

#Preview {
    AsyncImageBootCamp()
}
