//
//  MockDefaultCountryHandler.swift
//  CMEAssessmentTests
//
//  Created by Mina Wefky on 13/01/2025.
//

import Combine
@testable import CMEAssessment

class MockDefaultCountryHandler: DefaultCountryHandlerProtocol {
    var didDetermineDefaultCountry = false

    func determineDefaultCountry(availableCountries: [Country], locationCountry: String?) -> Country? {
        didDetermineDefaultCountry = true
        return availableCountries.first
    }
}
