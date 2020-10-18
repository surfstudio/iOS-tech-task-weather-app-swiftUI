//
//  Cityrepository.swift
//  Weather
//
//  Created by Александр Кравченков on 18.10.2020.
//

import Foundation
import NodeKit

struct CityCacheFirstRepository {

    private let cache: CityCacheService
    private let network: CityNetworkService

    init(cache: CityCacheService, network: CityNetworkService) {
        self.cache = cache
        self.network = network
    }
}

extension CityCacheFirstRepository: CityRepository {

    /// Возвращает все города, которые пользователь сохранил себе для просмотра
    /// Сначала читает данные из кеша
    ///     - Если получил ошибку - просто пробрасывает ее на верх и заканчивает работу
    ///
    /// После получения городов прокидывает их выше (это был кеш)
    /// Затем берет все города у которых протух кеш и перезапрашивает их из сети
    /// После этого обновляет кеш
    /// Затем мерджит обновленные данные и данные прочитанные ранее из кеша
    /// И пробрасывает новую пачку данных выше
    func getAllSaved() -> CacheContext<[CityDetailedWeatherEntity]> {
        let result = CacheContext<[CityDetailedWeatherEntity]>()

        self.cache.getAll().onCompleted { items in
            let expiredItems = items.filter { $0.isExpired }

            // Если не нашлось ни одного итема, у которого протух кеш то есть isEmpty == true
            // это значит, что кеш не протухший, а значит isExpired == false ==> isExpired = !isEmpty
            result.emitCache(items.map { $0.value }, isExpired: !expiredItems.isEmpty)

            // если есть итемы  у которых протух кеш, то идем дальше
            // если у всех кеш свежий, то просто выходим
            guard !expiredItems.isEmpty else { return }

            // перезапрашиваем из сети те итемы, у которых протух кеш
            result.emitStartLoading()
            self.network.getCitiesDetailedWeather(by: expiredItems.map { $0.value.cityId })
                .dispatchOn(.global())  // потенциально тяжелая операция, нечего грузить главный поток
                .onCompleted { cities in
                    // Передадим слушаетлю всю пачку моделей
                    // Для этого нужно взять старые модели и заменить в них те которые протухли на свежие
                    let newItems = items.compactMap { item -> CityDetailedWeatherEntity? in
                        guard item.isExpired else { return item.value }

                        return cities.first(where: { $0.cityId == item.value.cityId })
                    }

                    result.emit(data: newItems)

                    // Сохраняем то что пришло
                    _ = self.cache.save(cites: cities)
                }.onError { err in
                    result.emit(error: err)
                }
        }.onError { err in
            print("ERR; While reading cache in \(#function) : \(err)")
            result.emit(error: err)
        }

        return result.dispatch(on: .main)
    }

}
