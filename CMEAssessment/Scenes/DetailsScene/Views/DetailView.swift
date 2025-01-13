//
//  DetailView.swift
//  CMEAssessment
//
//  Created by Mina Wefky on 13/01/2025.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue.opacity(0.3), .white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                
                Text(viewModel.name)
                    .font(.title)
                    .bold()
                    .foregroundColor(.primary)
                
                if let flagURL = viewModel.flagURL {
                    AsyncImage(url: flagURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 5)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 150, height: 100)
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Capital:")
                            .font(.headline)
                        Spacer()
                        Text(viewModel.capital)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }

                    HStack {
                        Text("Currency:")
                            .font(.headline)
                        Spacer()
                        Text(viewModel.currency)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(radius: 5)
                )
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .navigationTitle(viewModel.name)
    }
}
