//
//  PersistenceCoordinatorProvider.swift
//  Weather
//
//  Created by Александр Кравченков on 16.10.2020.
//

import CoreData

/// Интерфейс для сущности, способной поставить `NSPersistentContainer`
///
/// Для получения контейнера необходимо использовать именно инъекцию зависимости через интерфейс провайдера
///
/// Реализация по-умолчанию: `AppDelegate`
protocol PersistenceCoordinatorProvider {
    func get() -> NSPersistentContainer
}
