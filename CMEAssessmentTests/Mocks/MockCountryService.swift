//
//  MockCountryService.swift
//  CMEAssessmentTests
//
//  Created by Mina Wefky on 13/01/2025.
//

import Combine
@testable import CMEAssessment

class MockCountryService: CountryService {
    var mockCountries: [Country] = []
    var shouldFail = false

    override func fetchCountries() async throws -> [Country] {
        if shouldFail {
            throw NetworkError.requestFailed
        }
        return mockCountries
    }
}

