////
////  CoinImageView.swift
////  SwiftfulCrypto
////
////  Created by Akanksha on 02/09/26.
////
//
import SwiftUI
import Combine


struct CoinImageView: View {

    @StateObject var vm: CoinImageViewModel

    init(coin: CoinModel, serviceFactory: ServiceFactory = .production()) {
        _vm = StateObject(
            wrappedValue: CoinImageViewModel(
                coin: coin,
                serviceFactory: serviceFactory
            )
        )
    }

    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryTextColor)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {

    static var previews: some View {
        CoinImageView(coin: DeveloperPreview.instance.coin)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
