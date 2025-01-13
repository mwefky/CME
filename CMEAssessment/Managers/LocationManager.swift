//
//  LocationManager.swift
//  CMEAssessment
//
//  Created by Mina Wefky on 13/01/2025.
//

import CoreLocation

import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private let persistenceManager: PersistenceManager

    @Published var currentCountry: String?
    @Published var locationError: String?
    @Published var isPermissionDenied: Bool = false

    init(persistenceManager: PersistenceManager = PersistenceManager()) {
        self.persistenceManager = persistenceManager
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocation() {
        let status = locationManager.authorizationStatus
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            isPermissionDenied = true
            currentCountry = nil 
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        @unknown default:
            isPermissionDenied = true
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            isPermissionDenied = true
            currentCountry = nil
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        print("Location received: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        locationManager.stopUpdatingLocation()

        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            if let error = error {
                self?.locationError = error.localizedDescription
                print("Geocoding error: \(error.localizedDescription)")
            } else if let placemark = placemarks?.first {
                let countryName = placemark.country ?? "Egypt" // Fallback to "Egypt"
                self?.currentCountry = countryName
                print("Resolved country: \(countryName)")
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
        locationError = error.localizedDescription
    }
}
