//
//  MainViewUITests.swift
//  CMEAssessmentUITests
//
//  Created by Mina Wefky on 13/01/2025.
//

import XCTest

class MainViewUITests: XCTestCase {
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
    
    func testSearchAndAddCountry() {
        let searchField = app.textFields["Search for a country"]
        XCTAssertTrue(searchField.exists, "Search field should exist.")
        
        searchField.tap()
        searchField.typeText("Egypt")
        let countryButton = app.buttons["Egypt"]
        XCTAssertTrue(countryButton.exists, "The suggestion for 'Egypt' should appear.")
        countryButton.tap()
        
        let countryCell = app.staticTexts["Egypt"]
        XCTAssertTrue(countryCell.exists, "The country 'Egypt' should be added to the list.")
    }
    
    func testRemoveCountry() {
        addCountry("Egypt")
        let countryCell = app.staticTexts["Egypt"]
        XCTAssertTrue(countryCell.exists, "The country 'Egypt' should exist before deletion.")
        
        countryCell.swipeLeft()
        let deleteButton = app.buttons["DeleteButton"]
        XCTAssertTrue(deleteButton.exists, "Delete button should appear after swiping left.")
        deleteButton.tap()
        
        XCTAssertFalse(countryCell.exists, "The country 'Egypt' should be removed after deletion.")
    }
    
    func testAddDuplicateCountry() {
        addCountry("Egypt")
        addCountry("Egypt")
        
        let countryCells = app.staticTexts.matching(identifier: "Egypt")
        XCTAssertEqual(countryCells.count, 1, "The country 'Egypt' should not be added more than once.")
    }
    
    func testNavigateToDetailsView() {
        addCountry("Egypt")
        
        let countryCell = app.staticTexts["Egypt"]
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: countryCell, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(countryCell.exists, "The country 'Egypt' should be visible.")
        
        countryCell.tap()
        
        let detailViewTitle = app.navigationBars["Egypt"]
        expectation(for: exists, evaluatedWith: detailViewTitle, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(detailViewTitle.exists, "Navigating to the details view of 'Egypt' should work.")
    }

    
    func testDefaultCountryAdded() {
        let defaultCountryCell = app.staticTexts["Egypt"]
        XCTAssertTrue(defaultCountryCell.exists, "The default country 'Egypt' should be added on first launch.")
    }
    
    // MARK: - Helper Functions
    
    private func addCountry(_ countryName: String) {
        let searchField = app.textFields["Search for a country"]
        XCTAssertTrue(searchField.exists, "Search field should exist.")
        
        searchField.tap()
        searchField.typeText(countryName)
        let countryButton = app.buttons[countryName]
        XCTAssertTrue(countryButton.exists, "The suggestion for \(countryName) should appear.")
        countryButton.tap()
    }
}
