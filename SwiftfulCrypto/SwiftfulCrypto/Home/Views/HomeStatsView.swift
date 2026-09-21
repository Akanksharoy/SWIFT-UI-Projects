//
//  HomeStatsView.swift
//  SwiftfulCrypto
//
//  Created by Akanksha on 08/09/26.
//

import SwiftUI

struct HomeStatsView: View {

    @EnvironmentObject private var homeViewModel: HomeViewModel

    @Binding var showPortfolio: Bool

    var body: some View {

        HStack(spacing: 0) {

            if showPortfolio {

                ForEach(homeViewModel.statistics.dropFirst()) { stat in
                    StatisticView(stat: stat)
                        .frame(maxWidth: .infinity)
                }

            } else {

                ForEach(homeViewModel.statistics.dropLast()) { stat in
                    StatisticView(stat: stat)
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

#Preview {
    HomeStatsView(showPortfolio: .constant(true))
        .environmentObject(DeveloperPreview.instance.home)
}
