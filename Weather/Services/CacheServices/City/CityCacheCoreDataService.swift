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

    func save(city: CityDetailedWeatherEntity) -> Observer<Void> {
        let result = Context<Void>()
        let context = persistenceContainerProvider.get().newBackgroundContext()
        context.mergePolicy = NSMergePolicy.overwrite
        context.perform {
            let wholeCity = CacheWholeCityInfo(context: context)
            wholeCity.city = city.toCache(context: context)
            wholeCity.createdAt = Date()
            do {
                try context.save()
                result.emit(data: ())
            } catch {
                result.emit(error: error)
            }
        }

        return result.dispatchOn(.main)
    }

    func get(by id: Int) -> Observer<CachedCity> {
        let context = persistenceContainerProvider.get().newBackgroundContext()
        let result = Context<CachedCity>()

        context.perform {
            let request: NSFetchRequest<CacheWholeCityInfo> = CacheWholeCityInfo.fetchRequest()

            request.predicate = NSPredicate(format: "city.cityId == %d", id)
            request.fetchLimit = 1

            do {
                let models = try request.execute()
                guard let model = models.first else {
                    result.emit(error: CityCacheCoreDataServiceError.notFound)
                    return
                }

                let isExpired = model.createdAt.isExpired(ttl: CachedServiceContants.timeToLife)
                let cachedModel = CachedCity(isExpired: isExpired, value: model.city.toEntity())
                result.emit(data: cachedModel)
            } catch {
                result.emit(error: error)
            }

        }

        return result.dispatchOn(.main)
    }

    func getAll(limit: Int, offset: Int) -> Observer<[CachedCity]> {
        let context = persistenceContainerProvider.get().newBackgroundContext()
        let result = Context<[CachedCity]>()

        context.perform {
            let request: NSFetchRequest<CacheWholeCityInfo> = CacheWholeCityInfo.fetchRequest()
            request.fetchOffset = offset
            request.fetchLimit = limit

            do {
                let models = try request.execute().map { item -> CachedCity in
                    let isExpired = item.createdAt.isExpired(ttl: CachedServiceContants.timeToLife)
                    return CachedCity(isExpired: isExpired, value: item.city.toEntity())
                }
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
}
