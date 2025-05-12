//
//  ApiClient.swift
//  BuggyCoins
//
//  Created by Sakda Suwantheerangkoon on 12/5/2568 BE.
//

import Foundation

protocol ApiClient {
    func httpGet<T: Decodable>(_ relativePath: String) async throws -> T
}

class CoinGeckoApiClient: ApiClient {
    private let basePath = "https://api.coingecko.com/api/v3/"
    
    func httpGet<T: Decodable>(_ relativePath: String) async throws -> T {
        guard let url = URL(string: basePath + relativePath) else {
            throw ApiClientError.invalidUrl
        }
        let (data, httpResponse) = try await URLSession.shared.data(from: url)
        if (httpResponse as? HTTPURLResponse)?.statusCode != 200 {
            throw ApiClientError.failStatus(code: (httpResponse as? HTTPURLResponse)?.statusCode ?? 500)
        }
        do {
            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw ApiClientError.other(message: error.localizedDescription)
        }
    }
}

enum ApiClientError: Error {
    case invalidUrl
    case failStatus(code: Int)
    case other(message: String)
}
