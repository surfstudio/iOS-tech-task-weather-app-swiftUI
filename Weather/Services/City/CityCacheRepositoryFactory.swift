//
//  CityCacheRepositoryFactory.swift
//  Weather
//
//  Created by Александр Кравченков on 19.10.2020.
//

import Foundation

struct CityCacheRepositoryFactory {

    private let pcProvider: PersistenceCoordinatorProvider

    init(pcProvider: PersistenceCoordinatorProvider = DefaultPCProvider()) {
        self.pcProvider = pcProvider
    }

    func produce() -> CityCacheRepository {
        return .init(cache: CityCacheCoreDataService(persistenceContainerProvider: self.pcProvider),
                     cityNetwork: CityNetworkService(),
                     weatherNetwork: DetailedWeatherNetworkService())
    }
}
