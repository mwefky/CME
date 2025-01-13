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
    }

    func testLoadCountries() async {
        mockCountryService.mockCountries = [Country(name: "Egypt", capital: "Cairo", currency: "EGP", flagURL: "")]
        await viewModel.loadCountries()
        
        XCTAssertEqual(viewModel.countries.count, 1)
        XCTAssertEqual(viewModel.countries.first?.name, "Egypt")
    }

    func testAddCountry() {
        let country = Country(name: "Egypt", capital: "Cairo", currency: "EGP", flagURL: "")
        viewModel.addCountry(country)
        
        XCTAssertEqual(viewModel.addedCountries.count, 1)
        XCTAssertEqual(viewModel.addedCountries.first?.name, "Egypt")
    }

    func testRemoveCountry() {
        let country = Country(name: "Egypt", capital: "Cairo", currency: "EGP", flagURL: "")
        viewModel.addCountry(country)
        viewModel.removeCountry(country)
        
        XCTAssertEqual(viewModel.addedCountries.count, 0)
    }

    func testDefaultCountryLogic() {
        mockLocationManager.currentCountry = "Egypt"
        let country = Country(name: "Egypt", capital: "Cairo", currency: "EGP", flagURL: "")
        viewModel.countries = [country]
        viewModel.addDefaultCountryIfNeeded()
        
        XCTAssertEqual(viewModel.addedCountries.count, 1)
        XCTAssertEqual(viewModel.addedCountries.first?.name, "Egypt")
    }

    func testPermissionDenied() {
        mockLocationManager.isPermissionDenied = true
        XCTAssertTrue(viewModel.isPermissionDenied)
    }
}
