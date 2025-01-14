//
//  MockLocationManager.swift
//  CMEAssessmentTests
//
//  Created by Mina Wefky on 13/01/2025.
//

import Combine
@testable import CMEAssessment

class MockLocationManager: LocationManager {
    private var currentCountrySubject = CurrentValueSubject<String?, Never>(nil)

    override var currentCountry: String? {
        get { currentCountrySubject.value }
        set {
            currentCountrySubject.send(newValue)
            objectWillChange.send() // Notify subscribers manually
        }
    }

    var currentCountryPublisher: AnyPublisher<String?, Never> {
        currentCountrySubject.eraseToAnyPublisher()
    }
}

