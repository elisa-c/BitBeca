//
//  DetailsCodable.swift
//  DetailsLibrary
//
//  Created by Elisa Camillo on 19/04/21.
//

import Foundation

struct DetailsCodable: Codable {
    let abbreviation: String?
    let name: String?
    let dataSymbolsCount: Int?
    let volume1HrsUsd: Double?
    let volume1DayUsd: Double?
    let volume1MthUsd: Double?
    let priceUsd: Double?
    let idIcon: String?

    enum CodingKeys: String, CodingKey {
        case abbreviation = "asset_id"
        case name = "name"
        case dataSymbolsCount = "data_symbols_count"
        case volume1HrsUsd = "volume_1hrs_usd"
        case volume1DayUsd = "volume_1day_usd"
        case volume1MthUsd = "volume_1mth_usd"
        case priceUsd = "price_usd"
        case idIcon = "id_icon"
    }
}


