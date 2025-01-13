//
//  CountryDTO.swift
//  CMEAssessment
//
//  Created by Mina Wefky on 13/01/2025.
//

import Foundation

struct CountryDTO: Decodable {
    let name: String
    let population: Int
    let region: String
    let capital: String?
    let currencies: [CurrencyDTO]?
    let flags: FlagsDTO

    struct FlagsDTO: Decodable {
        let png: String?
    }

    struct CurrencyDTO: Decodable {
        let name: String?
    }
}


