//
//  HomeViewModel.swift
//  BuggyCoins
//
//  Created by Sakda Suwantheerangkoon on 12/5/2568 BE.
//

import Foundation

final class HomeViewModel : ObservableObject {
    private let coinDataSource: CoinDataSource
    
    @Published var uiState: HomeUiState = .loading
    @Published var isNavigatedToDetail: Bool = false
    @Published var isNavigatedToSettings: Bool = false
    
    var selectedSymbol: String? = nil
    
    init(coinDataSource: CoinDataSource = CoinRemoteSource()) {
        self.coinDataSource = coinDataSource
    }
    
    func fetchCoinList(forceRefresh: Bool = false) {
        switch uiState {
            case .success(_, let timestamp) :
                if !(forceRefresh && getTimeSec() - timestamp > 60) {
                    return
                }
            default : break
        }
        Task { @MainActor in
            do {
                let coinList = try await coinDataSource.getCoinList()
//                let coinList: [CoinSimpleModel] = [
//                    CoinSimpleModel(symbol: "btc", name: "Bitcoin 1", image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", currentPrice: 123456.78, priceChangePercentage24h: 12.51),
//                    CoinSimpleModel(symbol: "eth", name: "Ethereum 1", image: "https://coin-images.coingecko.com/coins/images/279/large/ethereum.png?1696501628", currentPrice: 2520.89, priceChangePercentage24h: 0),
//                    CoinSimpleModel(symbol: "xrp", name: "XRP 1", image: "https://coin-images.coingecko.com/coins/images/44/large/xrp-symbol-white-128.png?1696501442", currentPrice: 24.36, priceChangePercentage24h: 1.1),
//                    CoinSimpleModel(symbol: "btc", name: "Bitcoin 2", image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", currentPrice: 123456.78, priceChangePercentage24h: -0.9),
//                    CoinSimpleModel(symbol: "eth", name: "Ethereum 2", image: "https://coin-images.coingecko.com/coins/images/279/large/ethereum.png?1696501628", currentPrice: 2520.89, priceChangePercentage24h: -1.142),
//                    CoinSimpleModel(symbol: "xrp", name: "XRP 2", image: "https://coin-images.coingecko.com/coins/images/44/large/xrp-symbol-white-128.png?1696501442", currentPrice: 24.36, priceChangePercentage24h: 2),
//                    CoinSimpleModel(symbol: "btc", name: "Bitcoin 3", image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", currentPrice: 123456.78, priceChangePercentage24h: 3),
//                    CoinSimpleModel(symbol: "eth", name: "Ethereum 3", image: "https://coin-images.coingecko.com/coins/images/279/large/ethereum.png?1696501628", currentPrice: 2520.89, priceChangePercentage24h: -4),
//                    CoinSimpleModel(symbol: "xrp", name: "XRP 3", image: "https://coin-images.coingecko.com/coins/images/44/large/xrp-symbol-white-128.png?1696501442", currentPrice: 24.36, priceChangePercentage24h: -1.834560),
//                    CoinSimpleModel(symbol: "btc", name: "Bitcoin 4", image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", currentPrice: 123456.78, priceChangePercentage24h: -9.113),
//                    CoinSimpleModel(symbol: "eth", name: "Ethereum 4", image: "https://coin-images.coingecko.com/coins/images/279/large/ethereum.png?1696501628", currentPrice: 2520.89, priceChangePercentage24h: 0),
//                    CoinSimpleModel(symbol: "xrp", name: "XRP 4", image: "https://coin-images.coingecko.com/coins/images/44/large/xrp-symbol-white-128.png?1696501442", currentPrice: 24.36, priceChangePercentage24h: 4.8)
//                ]
                uiState = .success(
                    coinList: coinList,
                    timestamp: getTimeSec()
                )
            } catch {
                uiState = .error(error)
            }
        }
    }
    
    func selectCoin(symbol: String) {
        selectedSymbol = symbol
        isNavigatedToDetail.toggle()
    }
    
    func getTimeSec() -> Int {
        return Int(Date().timeIntervalSince1970)
    }
}
