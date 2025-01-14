//
//  MainViewModelTests.swift
//  CMEAssessmentTests
//
//  Created by Mina Wefky on 13/01/2025.
//

import XCTest
import Combine
@testable import CMEAssessment

class MainViewModelTests: XCTestCase {
    var viewModel: MainViewModel!
    var mockCountryService: MockCountryService!
    var mockCountryManager: MockCountryManager!
    var mockLocationManager: MockLocationManager!

    override func setUp() {
        super.setUp()
        mockCountryService = MockCountryService()
        mockCountryManager = MockCountryManager()
        mockLocationManager = MockLocationManager()
        viewModel = MainViewModel(
            countryService: mockCountryService,
            countryManager: mockCountryManager,
            locationManager: mockLocationManager
        )
        for country in mockCountryManager.addedCountries {
            mockCountryManager.removeCountry(country)
        }
    }

    override func tearDown() {
        viewModel = nil
        mockCountryService = nil
        mockCountryManager = nil
        mockLocationManager = nil
        super.tearDown()
    }

    func testLoadCountries() async {
        // Arrange
        mockCountryService.mockCountries = [
            Country(name: "Egypt", capital: "Cairo", currency: "EGP", flagURL: "")
        ]
        // Act
        await Task.yield()

        // Assert
        XCTAssertEqual(mockCountryService.mockCountries.count, 1)
        XCTAssertEqual(mockCountryService.mockCountries.first?.name, "Egypt")
    }

    func testAddCountry() {
        // Arrange
        let country = Country(name: "Egypt", capital: "Cairo", currency: "EGP", flagURL: "")

        // Act
        viewModel.addCountry(country)

        // Assert
        XCTAssertEqual(viewModel.addedCountries.count, 1)
        XCTAssertEqual(viewModel.addedCountries.first?.name, "Egypt")
    }

    func testRemoveCountry() {
        // Arrange
        let country = Country(name: "Egypt", capital: "Cairo", currency: "EGP", flagURL: "")
        viewModel.addCountry(country)

        // Act
        viewModel.removeCountry(country)

        // Assert
        XCTAssertEqual(viewModel.addedCountries.count, 0)
    }

    func testDefaultCountryLogic() {
        // Arrange
        mockLocationManager.currentCountry = "Egypt"
        let country = Country(name: "Egypt", capital: "Cairo", currency: "EGP", flagURL: "")
        viewModel.countries = [country]

        // Assert
        XCTAssertEqual(viewModel.addedCountries.count, 1)
        XCTAssertEqual(viewModel.addedCountries.first?.name, "Egypt")
    }

    func testPermissionDenied() {
        // Act
        mockLocationManager.isPermissionDenied = true

        // Assert
        XCTAssertTrue(viewModel.isPermissionDenied)
    }
}
