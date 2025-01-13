//
//  CountryDTO.swift
//  CMEAssessment
//
//  Created by Mina Wefky on 13/01/2025.
//

import Foundation

struct CountryDTO: Decodable {
    let name: String
    let population: Int
    let region: String
    let flagURL: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case population
        case region
        case flags
    }
    
    enum FlagsCodingKeys: String, CodingKey {
        case png
    }
    
    // Custom initializer to handle nested `flags` key
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        population = try container.decode(Int.self, forKey: .population)
        region = try container.decode(String.self, forKey: .region)
        
        let flagsContainer = try container.nestedContainer(keyedBy: FlagsCodingKeys.self, forKey: .flags)
        flagURL = try flagsContainer.decode(String.self, forKey: .png)
    }
}

