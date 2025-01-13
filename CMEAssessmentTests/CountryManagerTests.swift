//
//  CountryManagerTests.swift
//  CMEAssessmentTests
//
//  Created by Mina Wefky on 13/01/2025.
//

import XCTest
import Combine
@testable import CMEAssessment

class CountryManagerTests: XCTestCase {
    var countryManager: CountryManager!

    override func setUp() {
        super.setUp()
        countryManager = CountryManager()
        for country in countryManager.addedCountries {
            countryManager.removeCountry(country)
        }
    }

    func testAddCountry() {
        let country = Country(name: "Egypt", capital: "Cairo", currency: "EGP", flagURL: "")
        countryManager.addCountry(country)
        
        XCTAssertEqual(countryManager.addedCountries.count, 1)
        XCTAssertEqual(countryManager.addedCountries.first?.name, "Egypt")
    }

    func testRemoveCountry() {
        
        let country = Country(name: "Egypt", capital: "Cairo", currency: "EGP", flagURL: "")
        countryManager.addCountry(country)
        countryManager.removeCountry(country)
        
        XCTAssertEqual(countryManager.addedCountries.count, 0)
    }

    func testLimitToFiveCountries() {
        for i in 1...6 {
            let country = Country(name: "Country \(i)", capital: "Capital \(i)", currency: "Currency \(i)", flagURL: "")
            countryManager.addCountry(country)
        }
        
        XCTAssertEqual(countryManager.addedCountries.count, 5)
        XCTAssertEqual(countryManager.addedCountries.first?.name, "Country 2")
    }
}
