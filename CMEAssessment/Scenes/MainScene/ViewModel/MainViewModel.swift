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
    @Published var addedCountries: [Country] = []
    @Published var countryNames: [String] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let countryService = CountryService()
    
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
        guard addedCountries.count < 5 else { return }
        if !addedCountries.contains(where: { $0.name == country.name }) {
            addedCountries.append(country)
        }
    }
    
    func removeCountry(_ country: Country) {
        addedCountries.removeAll { $0.name == country.name }
    }
}
