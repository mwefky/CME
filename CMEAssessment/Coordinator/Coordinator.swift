//
//  AppCoordinator.swift
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
    
    @Published var isDetailViewPresented: Bool = false
    
    func start() -> some View {
        MainView(viewModel: mainViewModel, coordinator: self)
    }
    
    func showDetail(for country: Country) {
        selectedCountry = country
        isDetailViewPresented = true
    }
}
