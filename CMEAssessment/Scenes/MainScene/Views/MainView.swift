//
//  MainView.swift
//  CMEAssessment
//
//  Created by Mina Wefky on 13/01/2025.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    @ObservedObject var coordinator: AppCoordinator
    @State private var showAlert = false
    @State private var countryToDelete: Country?

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.3), .white]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    SearchBar(
                        text: $viewModel.searchQuery,
                        suggestions: viewModel.countryNames
                    ) { selectedCountryName in
                        if let country = viewModel.countries.first(where: { $0.name == selectedCountryName }) {
                            withAnimation(.spring()) {
                                viewModel.addCountry(country)
                            }
                        }
                    }

                    if viewModel.isLoading {
                        ProgressView("Loading countries...")
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                            .shadow(radius: 5)
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    } else {
                        List {
                            ForEach(viewModel.addedCountries.reversed(), id: \.name) { country in
                                CountryCardView(country: country)
                                    .listRowBackground(Color.clear) // Set the background of each row
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.white.opacity(0.8))
                                            .shadow(radius: 5)
                                    )
                                    .padding(.vertical, 4)
                                    .onTapGesture {
                                        coordinator.selectedCountry = country
                                    }
                            }
                            .onDelete(perform: deleteCountry)
                        }
                        .listStyle(PlainListStyle())
                        .background(Color.clear)
                    }
                }
            }
            .onAppear {
                viewModel.loadCountries()
            }
            .navigationTitle("Countries")
        }
    }

    private func deleteCountry(at offsets: IndexSet) {
        for index in offsets {
            let reversedIndex = viewModel.addedCountries.count - 1 - index
            let country = viewModel.addedCountries[reversedIndex]
            viewModel.removeCountry(country)
        }
    }
}
