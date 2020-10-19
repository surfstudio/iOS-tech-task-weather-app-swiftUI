//
//  CityDetailedListEntry.swift
//  Weather
//
//  Created by Александр Кравченков on 19.10.2020.
//

import Foundation
import NodeKit

struct CityDetailedListEntry: Codable {
    let list: [CityDetailedWeatherEntry]
}

extension CityDetailedListEntry: RawMappable {
    typealias Raw = Json
}
