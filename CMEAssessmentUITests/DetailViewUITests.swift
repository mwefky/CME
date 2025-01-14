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
        
        let detailTitle = app.staticTexts["Egypt"]
        XCTAssertTrue(detailTitle.exists, "DetailView title should display the country's name.")
        
        let capitalLabel = app.staticTexts["Capital: Cairo"]
        XCTAssertTrue(capitalLabel.exists, "The capital 'Cairo' should be displayed.")
    }
    
    func testDetailViewBackNavigation() {
        addCountryAndNavigateToDetails("Egypt")
        
        // Perform swipe down gesture to dismiss the sheet
        let startCoordinate = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.2))
        let endCoordinate = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.8))
        startCoordinate.press(forDuration: 0.1, thenDragTo: endCoordinate)
        
        // Verify navigation back to MainView
        let mainViewTitle = app.navigationBars["Countries"]
        XCTAssertTrue(mainViewTitle.exists, "The app should navigate back to the MainView after dismissing the DetailView.")
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
        countryCell.forceTapElement()
    }
}
