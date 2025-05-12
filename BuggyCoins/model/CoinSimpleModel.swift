//
//  CoinSimpleModel.swift
//  BuggyCoins
//
//  Created by Sakda Suwantheerangkoon on 12/5/2568 BE.
//

import Foundation

struct CoinSimpleModel: Codable {
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let priceChangePercentage24h: Double
    
    func getFormattedPrice() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedPrice = numberFormatter.string(from: NSNumber(value: currentPrice)) ?? "-"
        return formattedPrice
    }
    
    func getFormattedPriceChangePercentage() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        let formattedChange = numberFormatter.string(from: NSNumber(value: abs(priceChangePercentage24h))) ?? "0.0"
        let prefix = priceChangePercentage24h < 0 ? "-" : "+"
        return "\(prefix)\(formattedChange)%"
    }
    
    enum CodingKeys: String, CodingKey {
        case symbol = "symbol"
        case name = "name"
        case image = "image"
        case currentPrice = "current_price"
        case priceChangePercentage24h = "price_change_percentage_24h"
    }
}
