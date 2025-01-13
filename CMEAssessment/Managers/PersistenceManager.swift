//
//  PersistenceManager.swift
//  CMEAssessment
//
//  Created by Mina Wefky on 13/01/2025.
//

import Foundation

class PersistenceManager {
    private let userDefaults = UserDefaults.standard
    private let addedCountriesKey = "addedCountries"

    func saveAddedCountries(_ countries: [Country]) {
        do {
            let data = try JSONEncoder().encode(countries)
            userDefaults.set(data, forKey: addedCountriesKey)
        } catch {
            print("Error saving countries: \(error)")
        }
    }

    func loadAddedCountries() -> [Country] {
        guard let data = userDefaults.data(forKey: addedCountriesKey) else { return [] }
        do {
            return try JSONDecoder().decode([Country].self, from: data)
        } catch {
            print("Error loading countries: \(error)")
            return []
        }
    }
}
