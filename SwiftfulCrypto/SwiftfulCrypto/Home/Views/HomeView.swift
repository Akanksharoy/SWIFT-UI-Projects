//
//  HomeView.swift
//  SwiftfulCrypto
//
//  Created by Akanksha on 23/08/26.
//

import SwiftUI
import Combine

struct HomeView: View {
    @EnvironmentObject private var viewModel:HomeViewModel
    @State private var showPortfolio: Bool = false // animate to the right
    @State private var showPortfolioView:Bool = false // new sheet
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
                
            VStack(spacing: 0) {
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $viewModel.searchText)
                columnTitles
                Spacer(minLength: 0)
                if !showPortfolio {
                    allCoinsList
                    .transition(.move(edge: .leading))
                }
                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                
            }
        }
        .onAppear {
            viewModel.reloadData()
        }
        .sheet(isPresented: $showPortfolioView) {
            PortfolioView()
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(
            HomeViewModel()
        )
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180.0 : 0.0))
                .onTapGesture {
                    withAnimation(.spring()){
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(viewModel.allCoins){
                coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    
            }
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(viewModel.portfolioCoins){
                coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
            }
        }
        .listStyle(.plain)
    }
    private var columnTitles:some View {
        HStack {
            Text("Coins")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
           
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5)
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    viewModel.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: viewModel.isLoading ? 360: 0), anchor: .center)

        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryTextColor)
        .padding(.horizontal)
    }
}

