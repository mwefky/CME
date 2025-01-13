//
//  SearchBar.swift
//  CMEAssessment
//
//  Created by Mina Wefky on 13/01/2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var suggestions: [String]
    var onSelection: (String) -> Void
    
    var body: some View {
        VStack {
            TextField("Search for a country", text: $text)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .shadow(radius: 5)
                .padding()
                .onSubmit {
                    hideKeyboard()
                }
            if !text.isEmpty {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(suggestions.filter { $0.lowercased().contains(text.lowercased()) }, id: \.self) { suggestion in
                            Button(action: {
                                onSelection(suggestion)
                                text.removeAll()
                                hideKeyboard()
                            }) {
                                HStack {
                                    HighlightedText(fullText: suggestion, highlighted: text)
                                    Spacer()
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 5).fill(Color.blue.opacity(0.1)))
                            }
                        }
                    }
                }
                .frame(height: 150)
                .padding(.horizontal)
            }
        }.animation(.easeInOut, value: text.isEmpty)
    }
}

struct HighlightedText: View {
    let fullText: String
    let highlighted: String
    
    var body: some View {
        let parts = fullText.lowercased().components(separatedBy: highlighted.lowercased())
        return Text(parts[0])
            .foregroundColor(.primary) +
        Text(highlighted)
            .foregroundColor(.blue)
            .bold() +
        Text(parts[1])
            .foregroundColor(.primary)
    }
}

