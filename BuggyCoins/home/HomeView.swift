//
//  HomeView.swift
//  BuggyCoins
//
//  Created by Sakda Suwantheerangkoon on 12/5/2568 BE.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        getHomeView()
            .task {
                viewModel.fetchCoinList()
            }
            .navDestination(isPresented: $viewModel.isNavigatedToDetail) {
                DetailView(coinSymbol: viewModel.selectedSymbol)
            }
            .sheet(isPresented: $viewModel.isNavigatedToSettings) {
                Text("Settings Krub")
            }
            .onOpenURL { url in
                if url.absoluteString.contains("buggycoins://detail") {
                    viewModel.selectCoin(
                        symbol: String(url.absoluteString.split(separator: "/").last!)
                    )
                }
            }
    }
    
    private func getHomeView() -> some View {
        return ScrollView(showsIndicators: false) {
            switch viewModel.uiState {
                case .success(let coinList, _):
                    getCoinListView(coinList)
                case .loading:
                    getLoadingView()
                case .error(let error):
                    getErrorView(error)
            }
        }
        .fillScreenWithBlurryStatusBar(isfadedBottom: true)
        .overlay(alignment: .top) {
            getToolbarView()
        }
        .background(Color("AppBG"))
    }
    
    private func getCoinListView(_ coinList: [CoinSimpleModel]) -> some View {
        return LazyVStack {
            Spacer().frame(height: 56)
            ForEach(coinList, id: \.name) { coin in
                getCoinItemView(coin)
            }
            Spacer().frame(height: 36)
        }
    }
    
    private func getCoinItemView(_ coin: CoinSimpleModel) -> some View {
        return Button(
            action: {
                UIApplication.shared.open(URL(string: "buggycoins://detail/link_\(coin.symbol)")!)
            }
        ) {
            HStack {
                AsyncImage(url: URL(string: coin.image)) { phase in
                    if let image = phase.image {
                        image.resizable()
                    } else {
                        Color.gray
                    }
                }
                .frame(width: 36, height: 36)
                
                VStack(alignment: .leading) {
                    Text(coin.name)
                        .foregroundStyle(.foreground)
                        .font(.body.weight(.bold))
                        .padding(.leading, 2)
                    Text("\(coin.symbol.uppercased()) \\ USD")
                        .foregroundStyle(.foreground.opacity(0.6))
                        .font(.caption.weight(.medium))
                        .padding(.leading, 3)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(coin.getFormattedPrice())
                        .foregroundStyle(.foreground)
                        .font(.body.weight(.bold))
                    
                    let tagColor: Color = switch coin.priceChangePercentage24h {
                        case 0: .gray
                        case ..<0: .red
                        default: .green
                    }
                    
                    Text(coin.getFormattedPriceChangePercentage())
                        .foregroundStyle(tagColor)
                        .font(.caption.weight(.medium))
                }
            }
        }
        .padding(.leading, 14)
        .padding(.trailing, 16)
        .padding(.vertical, 12)
        .background(.background.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.vertical, 2)
        .padding(.horizontal, 12)
        .frame(
            maxWidth: .infinity,
            alignment: .center
        )
        
    }
    
    private func getLoadingView() -> some View {
        return VStack {
            Text("Loading...")
                .foregroundStyle(.background)
                .font(.title3)
        }
    }
    
    private func getErrorView(_ error: Error) -> some View {
        return VStack {
            Text("Error: \(error)")
                .foregroundStyle(.white)
                .font(.title3)
        }
    }
    
    private func getToolbarView() -> some View {
        HStack {
            Text("Market")
                .font(.body.bold())
                .foregroundStyle(.foreground)
            Spacer()
            Button(
                action: {
                    viewModel.fetchCoinList(forceRefresh: true)
                },
                label: {
                    Image(systemName: "arrow.clockwise.circle.fill")
                        .resizable()
                        .foregroundStyle(.foreground)
                        .frame(width: 24, height: 24)
                }
            )
            Button(
                action: {
                    viewModel.isNavigatedToSettings.toggle()
                },
                label: {
                    Image(systemName: "gearshape.circle.fill")
                        .resizable()
                        .foregroundStyle(.foreground)
                        .frame(width: 24, height: 24)
                }
            )
            .padding(.leading, 8)
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .padding(.bottom, 12)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
    }
}

#Preview {
    HomeView()
}
