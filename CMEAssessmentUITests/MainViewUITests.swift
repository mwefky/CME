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
        // Arrange
        addCountry("Egypt") // Ensure the country is added
        let countryCell = app.staticTexts["Egypt"]
        
        // Assert the cell exists
        XCTAssertTrue(countryCell.exists, "The country 'Egypt' should exist before deletion.")
        
        // Act
        countryCell.swipeLeft(velocity: XCUIGestureVelocity.slow)
        
        // Wait for the delete button to appear
        let deleteButton = app.buttons["Delete"]
        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate, evaluatedWith: deleteButton, handler: nil)
        waitForExpectations(timeout: 2.0, handler: nil)
        
        XCTAssertTrue(deleteButton.exists, "Delete button should appear after swiping left.")
        deleteButton.tap()
        
        // Assert the cell is removed
        XCTAssertFalse(countryCell.exists, "The country 'Egypt' should be removed after deletion.")
    }

    
    func testAddDuplicateCountry() {
        addCountry("Egypt")
        addCountry("Egypt")
        
        let countryCells = app.staticTexts.matching(identifier: "Egypt")
        XCTAssertEqual(countryCells.count, 1, "The country 'Egypt' should not be added more than once.")
    }
    
    func testNavigateToDetailsView() {
        // Add a country to test navigation
        addCountry("Egypt")
        
        // Assert the country cell exists
        let countryCell = app.staticTexts["Egypt"]
        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate, evaluatedWith: countryCell, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(countryCell.exists, "The country 'Egypt' should be visible.")
        
        // Tap the cell
        countryCell.forceTapElement()
        
        // Verify the detail view sheet is presented
        let sheetPredicate = NSPredicate(format: "exists == true AND isHittable == true")

        // Verify the content inside the detail view
        let detailViewTitle = app.staticTexts["Egypt"]
        XCTAssertTrue(detailViewTitle.exists, "Detail view should display the country's name.")
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


extension XCUIElement {
    func forceTapElement() {
        if self.isHittable {
            self.tap()
        } else {
            let coordinate = self.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
            coordinate.tap()
        }
    }
}
