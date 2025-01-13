//
//  Country+Mapper.swift
//  CMEAssessment
//
//  Created by Mina Wefky on 13/01/2025.
//

import Foundation
struct CountryMapper {
    static func map(dto: CountryDTO) -> Country {
        return Country(
            name: dto.name,
            population: dto.population,
            region: dto.region,
            flagURL: dto.flagURL
        )
    }
}
