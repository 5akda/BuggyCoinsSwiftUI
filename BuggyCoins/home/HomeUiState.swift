//
//  HomeUiState.swift
//  BuggyCoins
//
//  Created by Sakda Suwantheerangkoon on 12/5/2568 BE.
//

import Foundation

enum HomeUiState {
    case loading
    case success(coinList: [CoinSimpleModel], timestamp: Int)
    case error(_ error: Error)
}
