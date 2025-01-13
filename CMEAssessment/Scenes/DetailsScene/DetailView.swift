//
//  DetailView.swift
//  CMEAssessment
//
//  Created by Mina Wefky on 13/01/2025.
//

import SwiftUI

struct DetailView: View {
    let country: Country?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Capital: \(country?.flagURL)")
                .font(.headline)
//            if let currency = country.currencies?.first {
//                Text("Currency: \(currency.name) (\(currency.code))")
//            }
        }
        .padding()
        .navigationTitle(country?.name ?? "")
    }
}
