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
            capital: dto.capital ?? "Unknown Capital",
            currency: dto.currencies?.first?.name ?? "Unknown Currency",
            flagURL: dto.flags.png ?? ""
        )
    }
}
