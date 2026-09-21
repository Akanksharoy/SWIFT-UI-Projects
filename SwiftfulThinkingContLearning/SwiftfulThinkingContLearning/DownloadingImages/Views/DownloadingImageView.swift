//
//  DownloadingImageView.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 31/08/26.
//

import SwiftUI

struct DownloadingImageView: View {
    @StateObject var viewModel: ImageLoadingViewModel
    init(url:String, key:String) {
        _viewModel = StateObject(wrappedValue: ImageLoadingViewModel(url: url, key: key))
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            }
            else if let image = viewModel.image{
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            }
        }
    }
}

#Preview {
    DownloadingImageView(url: "https://via.placeholder.com/600/92c952", key: "1")
}
