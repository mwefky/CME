//
//  CountryService.swift
//  CMEAssessment
//
//  Created by Mina Wefky on 13/01/2025.
//

import Foundation

class CountryService {
    private let networkManager = NetworkManager.shared

    func fetchCountries() async throws -> [Country] {
        do {
            let countryDTOs: [CountryDTO] = try await networkManager.fetchData(
                endpoint: "/all",
                cacheKey: AppConstants.cacheForCountriesKey
            )
            return countryDTOs.map(CountryMapper.map)
        } catch {
            throw error
        }
    }
}
