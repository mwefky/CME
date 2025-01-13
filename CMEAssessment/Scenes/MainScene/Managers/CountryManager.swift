//
//  CountryManager.swift
//  CMEAssessment
//
//  Created by Mina Wefky on 13/01/2025.
//

import Foundation

class CountryManager {
    private(set) var addedCountries: [Country] = []

    func addCountry(_ country: Country) {
        if addedCountries.count >= 5 {
            addedCountries.removeFirst()
        }
        if !addedCountries.contains(where: { $0.name == country.name }) {
            addedCountries.append(country)
        }
    }

    func removeCountry(_ country: Country) {
        addedCountries.removeAll { $0.name == country.name }
    }
}

