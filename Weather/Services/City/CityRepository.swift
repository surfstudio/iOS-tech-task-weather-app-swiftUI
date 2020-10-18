//
//  CityRepository.swift
//  Weather
//
//  Created by Александр Кравченков on 18.10.2020.
//

import Foundation
import NodeKit

protocol CityRepository {
    func getAllSaved() -> CacheContext<[CityDetailedWeatherEntity]>
}
