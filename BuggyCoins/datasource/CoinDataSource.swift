//
//  CoinDataSource.swift
//  BuggyCoins
//
//  Created by Sakda Suwantheerangkoon on 12/5/2568 BE.
//

import Foundation

protocol CoinDataSource {
    func getCoinList() async throws -> [CoinSimpleModel]
}

class CoinRemoteSource: CoinDataSource {
    private let apiClient: ApiClient
    
    init(apiClient: ApiClient = CoinGeckoApiClient()) {
        self.apiClient = apiClient
    }
    
    func getCoinList() async throws -> [CoinSimpleModel] {
        let currency = "usd"
        let supportedCoins = ["btc","eth","ltc","bch","bnb","eos","xrp","xlm","link","dot","yfi"]
        let path = "coins/markets?vs_currency=\(currency)&symbols=" + supportedCoins.joined(separator: "%2C")
        return try await apiClient.httpGet(path)
    }
}
