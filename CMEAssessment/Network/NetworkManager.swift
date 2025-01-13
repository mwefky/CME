//
//  NetworkManager.swift
//  CMEAssessment
//
//  Created by Mina Wefky on 13/01/2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
    case noData
}

class NetworkManager {
    static let shared = NetworkManager()
    private let cache = URLCache.shared
    private init() {}

    func fetchData<T: Decodable>(endpoint: String, cacheKey: String? = nil) async throws -> T {
        let urlString = "\(AppConstants.apiBaseURL)\(endpoint)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }

        let request = URLRequest(url: url)

        if let cachedResponse = cache.cachedResponse(for: request) {
            return try decodeData(from: cachedResponse.data)
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            if  let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let cachedResponse = CachedURLResponse(response: response, data: data)
                cache.storeCachedResponse(cachedResponse, for: request)
            }

            return try decodeData(from: data)
        } catch {
            throw NetworkError.requestFailed
        }
    }

    private func decodeData<T: Decodable>(from data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
