//
//  CountryManager.swift
//  CMEAssessment
//
//  Created by Mina Wefky on 13/01/2025.
//

import Foundation

class CountryManager {
    private let persistenceManager = PersistenceManager()
    private(set) var addedCountries: [Country] = []

    init() {
        addedCountries = persistenceManager.loadAddedCountries()
    }

    func addCountry(_ country: Country) {
        if addedCountries.count >= 5 {
            addedCountries.removeFirst()
        }

        addedCountries.append(country)
        persistenceManager.saveAddedCountries(addedCountries)
    }

    func removeCountry(_ country: Country) {
        addedCountries.removeAll { $0.name == country.name }
        persistenceManager.saveAddedCountries(addedCountries)
    }
}
