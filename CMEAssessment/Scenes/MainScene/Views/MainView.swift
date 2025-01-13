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
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(viewModel.addedCountries, id: \.name) { country in
                                    CountryCardView(country: country)
                                        .transition(.move(edge: .trailing))
                                        .onTapGesture {
                                            withAnimation {
                                                viewModel.removeCountry(country)
                                            }
                                        }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .onAppear {
                viewModel.loadCountries()
            }
            .navigationTitle("Countries")
        }
    }
}
