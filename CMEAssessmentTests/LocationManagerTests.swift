//
//  LocationManagerTests.swift
//  CMEAssessmentTests
//
//  Created by Mina Wefky on 13/01/2025.
//

import XCTest
import Combine
@testable import CMEAssessment

class LocationManagerTests: XCTestCase {
    var locationManager: LocationManager!

    override func setUp() {
        super.setUp()
        locationManager = LocationManager()
    }

    func testPermissionDenied() {
        locationManager.isPermissionDenied = true
        XCTAssertTrue(locationManager.isPermissionDenied)
    }

    func testGeocodingCountry() {
        let expectation = XCTestExpectation(description: "Geocode country")
        locationManager.currentCountry = "Egypt"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.locationManager.currentCountry, "Egypt")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
}
