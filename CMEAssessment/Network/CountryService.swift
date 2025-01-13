//
//  CountryService.swift
//  CMEAssessment
//
//  Created by Mina Wefky on 13/01/2025.
//

import Foundation

class CountryService {
    func fetchCountries() async throws -> [Country] {
        let urlString = "\(AppConstants.apiBaseURL)/all"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let countryDTOs = try JSONDecoder().decode([CountryDTO].self, from: data)
        return countryDTOs.map(CountryMapper.map)
    }
}


