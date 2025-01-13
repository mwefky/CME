//
//  PersistenceManagerTests.swift
//  CMEAssessmentTests
//
//  Created by Mina Wefky on 13/01/2025.
//

import XCTest
import Combine
@testable import CMEAssessment

class PersistenceManagerTests: XCTestCase {
    var persistenceManager: PersistenceManager!
    
    override func setUp() {
        super.setUp()
        persistenceManager = PersistenceManager()
    }

    func testSaveAndLoadCountries() {
        let country = Country(name: "Egypt", capital: "Cairo", currency: "EGP", flagURL: "")
        persistenceManager.saveAddedCountries([country])
        
        let loadedCountries = persistenceManager.loadAddedCountries()
        XCTAssertEqual(loadedCountries.count, 1)
        XCTAssertEqual(loadedCountries.first?.name, "Egypt")
    }
}
