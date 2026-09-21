//
//  DownloadingImagesBootCamp.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 29/08/26.
//

import SwiftUI

struct DownloadingImagesBootCamp: View {
    @StateObject private var viewModel = DownLoadingImagesViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.photoModel) {
                    model in
                    DownloadingImagesRow(model: model)
                }
            }
            .navigationTitle("Downloading Images")
        }
    }
}

#Preview {
    DownloadingImagesBootCamp()
}
