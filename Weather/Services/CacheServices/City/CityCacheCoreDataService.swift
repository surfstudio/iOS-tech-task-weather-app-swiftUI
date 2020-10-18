//
//  CityCacheCoreDataService.swift
//  Weather
//
//  Created by Александр Кравченков on 16.10.2020.
//

import Foundation
import CoreData
import NodeKit

enum CityCacheCoreDataServiceError: Error {
    case notFound
}

struct CityCacheCoreDataService: CityCacheService {

    let persistenceContainerProvider: PersistenceCoordinatorProvider

    func save(cites: [CityDetailedWeatherEntity]) -> Observer<Void> {
        let result = Context<Void>()
        let context = persistenceContainerProvider.get().newBackgroundContext()
        context.mergePolicy = NSMergePolicy.overwrite
        context.perform {
            cites.forEach { city in
                let wholeCity = CacheWholeCityInfo(context: context)
                wholeCity.city = city.toCache(context: context)
                wholeCity.cityId = Int32(city.cityId)
                wholeCity.createdAt = Date()
            }
            do {
                try context.save()
                result.emit(data: ())
            } catch {
                result.emit(error: error)
            }
        }

        return result.dispatchOn(.main)
    }

    func get(by id: Int) -> Observer<CityCacheResponse> {
        let context = persistenceContainerProvider.get().newBackgroundContext()
        let result = Context<CityCacheResponse>()

        context.perform {
            let request: NSFetchRequest<CacheWholeCityInfo> = CacheWholeCityInfo.fetchRequest()

            request.predicate = NSPredicate(format: "cityId == %d", id)
            request.fetchLimit = 1

            do {
                let models = try request.execute()
                guard let model = models.first else {
                    result.emit(error: CityCacheCoreDataServiceError.notFound)
                    return
                }
                result.emit(data: .init(with: model))
            } catch {
                result.emit(error: error)
            }

        }

        return result.dispatchOn(.main)
    }

    func getAll() -> Observer<[CachedCity]> {
        let context = persistenceContainerProvider.get().newBackgroundContext()
        let result = Context<[CachedCity]>()

        context.perform {
            let request: NSFetchRequest<CacheWholeCityInfo> = CacheWholeCityInfo.fetchRequest()
            do {
                let models = try request.execute().map { CachedCity(with: $0) }
                result.emit(data: models)
            } catch {
                result.emit(error: error)
            }
        }

        return result.dispatchOn(.main)
    }

    func delete(by id: Int) -> Observer<Void> {
        let context = persistenceContainerProvider.get().newBackgroundContext()
        let result = Context<Void>()

        context.perform {
            let request: NSFetchRequest<CacheWholeCityInfo> = CacheWholeCityInfo.fetchRequest()

            request.predicate = NSPredicate(format: "city.cityId == %d", id)
            request.fetchLimit = 1

            do {
                let models = try request.execute()
                models.forEach { context.delete($0) }
                result.emit(data: ())
            } catch {
                result.emit(error: error)
            }

        }

        return result.dispatchOn(.main)
    }

    func save(detailedWeather: DetailedWeatherEntity, for cityId: Int) -> Observer<Void> {
        let context = persistenceContainerProvider.get().newBackgroundContext()
        let result = Context<Void>()

        context.perform {
            let request: NSFetchRequest<CacheWholeCityInfo> = CacheWholeCityInfo.fetchRequest()

            request.predicate = NSPredicate(format: "city.cityId == %d", cityId)
            request.fetchLimit = 1

            do {
                let models = try request.execute()

                guard let city = models.first else {
                    result.emit(error: CityCacheCoreDataServiceError.notFound)
                    return
                }

                if let weather = city.detailedWeather {
                    context.delete(weather)
                }

                city.detailedWeather = detailedWeather.toCache(context: context)

                try context.save()
            } catch {
                result.emit(error: error)
            }

        }

        return result.dispatchOn(.main)
    }
}

// MARK: - CachedModel<CityDetailedWeatherEntity> + Convertion

extension CachedModel where T == CityDetailedWeatherEntity {
    init(with model: CacheWholeCityInfo) {
        let isExpired = model.createdAt.isExpired(ttl: CachedServiceContants.timeToLife)
        self.init(isExpired: isExpired, value: model.city.toEntity())
    }
}

// MARK: - CachedModel<DetailedWeatherEntity> + Convertion

extension CachedModel where T == DetailedWeatherEntity {
    init?(with model: CacheWholeCityInfo) {

        guard let weather = model.detailedWeather?.toEntity() else {
            return nil
        }

        let isExpired = model.createdAt.isExpired(ttl: CachedServiceContants.timeToLife)
        self.init(isExpired: isExpired, value: weather)
    }
}

// MARK: - CityCacheResponse + Convertion

extension CityCacheResponse {
    init(with model: CacheWholeCityInfo) {
        self.init(city: .init(with: model),
                  weather: CachedModel(with: model))
    }
}
