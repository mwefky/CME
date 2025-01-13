//
//  Coordinator.swift
//  CMEAssessment
//
//  Created by Mina Wefky on 13/01/2025.
//

import SwiftUI

protocol Coordinator {
    associatedtype RootView: View
    func start() -> RootView
}

class AppCoordinator: ObservableObject, Coordinator {
    @Published var mainViewModel = MainViewModel()
    @Published var selectedCountry: Country?
    
    func start() -> some View {
        MainView(viewModel: mainViewModel, coordinator: self)
    }
    
    func showDetail(for country: Country) -> some View {
        DetailView(country: country)
    }
}

