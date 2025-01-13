//
//  DefaultCountryHandlerTests.swift
//  CMEAssessmentTests
//
//  Created by Mina Wefky on 13/01/2025.
//

import XCTest
import Combine
@testable import CMEAssessment

class DefaultCountryHandlerTests: XCTestCase {
    var defaultCountryHandler: DefaultCountryHandler!

    override func setUp() {
        super.setUp()
        defaultCountryHandler = DefaultCountryHandler()
    }

    func testDetermineDefaultCountryFromLocation() {
        let countries = [Country(name: "Egypt", capital: "Cairo", currency: "EGP", flagURL: "")]
        let defaultCountry = defaultCountryHandler.determineDefaultCountry(
            availableCountries: countries,
            locationCountry: "Egypt"
        )
        
        XCTAssertEqual(defaultCountry?.name, "Egypt")
    }

    func testFallbackToEgypt() {
        let countries = [Country(name: "Egypt", capital: "Cairo", currency: "EGP", flagURL: "")]
        let defaultCountry = defaultCountryHandler.determineDefaultCountry(
            availableCountries: countries,
            locationCountry: nil
        )
        
        XCTAssertEqual(defaultCountry?.name, "Egypt")
    }
}
