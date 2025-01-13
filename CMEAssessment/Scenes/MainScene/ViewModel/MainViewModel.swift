//
//  MainViewModel.swift
//  CMEAssessment
//
//  Created by Mina Wefky on 13/01/2025.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var countries: [Country] = []
    @Published var searchQuery: String = ""
    @Published var countryNames: [String] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    @Published var addedCountries: [Country] = [] 

    private let countryService: CountryService
    private let countryManager: CountryManager

    init(
        countryService: CountryService = CountryService(),
        countryManager: CountryManager = CountryManager()
    ) {
        self.countryService = countryService
        self.countryManager = countryManager
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
        countryManager.addCountry(country)
        addedCountries = countryManager.addedCountries
    }

    func removeCountry(_ country: Country) {
        countryManager.removeCountry(country)
        addedCountries = countryManager.addedCountries
    }
}
