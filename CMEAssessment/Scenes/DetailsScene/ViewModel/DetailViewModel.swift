//
//  DetailViewModel.swift
//  CMEAssessment
//
//  Created by Mina Wefky on 13/01/2025.
//

import Foundation

class DetailViewModel: ObservableObject {
    let country: Country

    init(country: Country) {
        self.country = country
    }

    var flagURL: URL? {
        URL(string: country.flagURL)
    }

    var name: String {
        country.name
    }

    var capital: String {
        country.capital
    }

    var currency: String {
        country.currency
    }
}
