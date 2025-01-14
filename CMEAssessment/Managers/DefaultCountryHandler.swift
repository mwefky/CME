//
//  DefaultCountryHandler.swift
//  CMEAssessment
//
//  Created by Mina Wefky on 13/01/2025.
//

import Foundation
import Foundation

protocol DefaultCountryHandlerProtocol {
    func determineDefaultCountry(
        availableCountries: [Country],
        locationCountry: String?
    ) -> Country?
}

class DefaultCountryHandler: DefaultCountryHandlerProtocol {
    private let persistenceManager = PersistenceManager()

    func determineDefaultCountry(
        availableCountries: [Country],
        locationCountry: String?
    ) -> Country? {
        // Check for location-derived country
        if let locationCountry = locationCountry,
           let country = availableCountries.first(where: { $0.name == locationCountry }) {
            return saveAndReturn(country)
        }

        // Fallback to "Egypt"
        if let defaultCountry = availableCountries.first(where: { $0.name == "Egypt" }) {
            return saveAndReturn(defaultCountry)
        }

        // No country found
        return nil
    }

    private func saveAndReturn(_ country: Country) -> Country {
        return country
    }
}
