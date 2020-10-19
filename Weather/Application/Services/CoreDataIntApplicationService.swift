//
//  CoreDataIntApplicationService.swift
//  Weather
//
//  Created by Александр Кравченков on 16.10.2020.
//

import Foundation
import CoreData
import PluggableApplicationDelegate

class CoreDataIntApplicationService: NSObject, ApplicationService {

    lazy var persistenceContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CacheModel")

        container.loadPersistentStores { (descr, error) in
            print(descr)
            guard let error = error else { return }
            fatalError("Whileinitialize NSPersistentContainer an error occured: \(error)")
        }

        return container
    }()

    private let repo: CityRepository

    init(repo: CityRepository) {
        self.repo = repo
        super.init()
    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        guard !UserDefaults.standard.isNotFirstLaunch else { return true }
        // Москва
        _ = self.repo
            .getCityBy(coords: .init(lon: 37.6155600, lat: 55.7522200))
            // да, здесь не нужен weak, потому что тут не может быть рейн цикла, так как Observer не удерживается этим объектом и сервисом
            .map { self.repo.save(city: $0) }
        // Минск
        _ = self.repo
            .getCityBy(coords: .init(lon: 27.5666700, lat: 53.9000000))
            // и тут тоже
            .map { self.repo.save(city: $0) }
        return true
    }
}
