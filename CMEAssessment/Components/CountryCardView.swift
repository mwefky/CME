//
//  CountryCardView.swift
//  CMEAssessment
//
//  Created by Mina Wefky on 13/01/2025.
//

import SwiftUI

struct CountryCardView: View {
    let country: Country
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(country.name)
                    .font(.headline)
                Spacer()
            }
            Text("Capital: \(country.region)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
//            if let currency = country.flagURL {
                Text("Currency: \(country.flagURL) (\(country.flagURL))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
//            }
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.2), .white]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

