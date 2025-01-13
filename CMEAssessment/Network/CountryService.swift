//
//  CountryService.swift
//  CMEAssessment
//
//  Created by Mina Wefky on 13/01/2025.
//

import Foundation

struct Country: Decodable {
    let name: String
    let capital: String
    let currencies: [Currency]?
}

struct Currency: Decodable {
    let code: String
    let name: String
    let symbol: String
}

class CountryService {
    private let apiURL = "https://restcountries.com/v2/all"
    
    func fetchCountries(completion: @escaping (Result<[Country], NetworkError>) -> Void) {
        NetworkManager.shared.fetchData(urlString: apiURL, completion: completion)
    }
}
