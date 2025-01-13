//
//  DetailViewUITests.swift
//  CMEAssessmentUITests
//
//  Created by Mina Wefky on 13/01/2025.
//

import XCTest

class DetailViewUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments += ["--reset"] // Reset the app state before each test
        app.launch()
    }
    
    override func tearDown() {
        app.terminate()
        super.tearDown()
    }
    
    func testDetailViewDisplaysCountryInfo() {
        // Navigate to the DetailView by selecting a country
        addCountryAndNavigateToDetails("Egypt")
        
        let detailTitle = app.navigationBars["Egypt"]
        XCTAssertTrue(detailTitle.exists, "DetailView navigation title should display the country's name.")
        
        let capitalLabel = app.staticTexts["Capital: Cairo"]
        XCTAssertTrue(capitalLabel.exists, "The capital 'Cairo' should be displayed.")
        
        let currencyLabel = app.staticTexts["Currency: EGP"]
        XCTAssertTrue(currencyLabel.exists, "The currency 'EGP' should be displayed.")
    }
    
    func testDetailViewDisplaysFlag() {
        // Navigate to the DetailView by selecting a country
        addCountryAndNavigateToDetails("Egypt")
        
        let flagImage = app.images["FlagImage"]
        XCTAssertTrue(flagImage.exists, "The flag image for 'Egypt' should be displayed.")
    }
    
    func testDetailViewBackNavigation() {
        addCountryAndNavigateToDetails("Egypt")
        
        let backButton = app.navigationBars.buttons.element(boundBy: 0)
        XCTAssertTrue(backButton.exists, "Back button should be present on the DetailView.")
        backButton.tap()
        
        let mainViewTitle = app.navigationBars["Countries"]
        XCTAssertTrue(mainViewTitle.exists, "The app should navigate back to the MainView.")
    }
    
    // MARK: - Helper Functions
    
    private func addCountryAndNavigateToDetails(_ countryName: String) {
        let searchField = app.textFields["Search for a country"]
        XCTAssertTrue(searchField.exists, "Search field should exist.")
        
        searchField.tap()
        searchField.typeText(countryName)
        let countryButton = app.buttons[countryName]
        XCTAssertTrue(countryButton.exists, "The suggestion for \(countryName) should appear.")
        countryButton.tap()
        
        let countryCell = app.staticTexts[countryName]
        XCTAssertTrue(countryCell.exists, "The country \(countryName) should be visible.")
        countryCell.tap()
    }
}
