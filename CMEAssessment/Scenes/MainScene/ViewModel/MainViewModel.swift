//
//  MainViewModel.swift
//  CMEAssessment
//
//  Created by Mina Wefky on 13/01/2025.
//

import Foundation
import Combine
import Foundation
import Combine

class MainViewModel: ObservableObject {
    @Published var countries: [Country] = []
    @Published var searchQuery: String = ""
    @Published var countryNames: [String] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var addedCountries: [Country] = []
    @Published var isPermissionDenied: Bool = false

    private let countryService: CountryService
    private let countryManager: CountryManager
    private let locationManager: LocationManager
    private let defaultCountryHandler: DefaultCountryHandlerProtocol
    private var cancellables = Set<AnyCancellable>()

    init(
        countryService: CountryService = CountryService(),
        countryManager: CountryManager = CountryManager(),
        locationManager: LocationManager = LocationManager(),
        defaultCountryHandler: DefaultCountryHandlerProtocol = DefaultCountryHandler()
    ) {
        self.countryService = countryService
        self.countryManager = countryManager
        self.locationManager = locationManager
        self.defaultCountryHandler = defaultCountryHandler

        self.addedCountries = countryManager.addedCountries

        locationManager.$currentCountry
            .sink { [weak self] countryName in
                guard let self = self, let countryName = countryName else { return }
                if let country = self.countries.first(where: { $0.name == countryName }) {
                    self.addCountry(country)
                }
            }
            .store(in: &cancellables)

        locationManager.$isPermissionDenied
            .assign(to: &$isPermissionDenied)
    }

    func loadCountries() {
        isLoading = true
        Task {
            do {
                let fetchedCountries = try await countryService.fetchCountries()
                DispatchQueue.main.async { [weak self] in
                    self?.countries = fetchedCountries
                    self?.countryNames = fetchedCountries.map { $0.name }
                    self?.isLoading = false
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.errorMessage = "Failed to fetch countries: \(error.localizedDescription)"
                    self?.isLoading = false
                }
            }
        }
    }

    func addCountry(_ country: Country) {
        guard !addedCountries.contains(where: { $0.name == country.name }) else { return }
        countryManager.addCountry(country)
        addedCountries = countryManager.addedCountries
    }

    func removeCountry(_ country: Country) {
        countryManager.removeCountry(country)
        addedCountries = countryManager.addedCountries
    }
}
