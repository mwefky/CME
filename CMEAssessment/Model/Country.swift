//
//  Country.swift
//  CMEAssessment
//
//  Created by Mina Wefky on 13/01/2025.
//

import Foundation

struct Country: Encodable,Decodable {
    let name: String
    let population: Int
    let region: String
    let capital: String
    let currency: String
    let flagURL: String
}
