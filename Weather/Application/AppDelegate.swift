//
//  Copyright © 2020 Surf. All rights reserved.
//

import PluggableApplicationDelegate
import UIKit
import CSTObfuscator
import CoreData

@UIApplicationMain
class AppDelegate: PluggableApplicationDelegate {

    // MARK: - Properties

    private let coreDataInitService = CoreDataIntApplicationService()

    override var services: [ApplicationService] {
        let rep = CityCacheRepository(cache: CityCacheCoreDataService(persistenceContainerProvider: self), cityNetwork: CityNetworkService(), weatherNetwork: DetailedWeatherNetworkService())
        rep.getAllSaved().onCompleted {
            print("RES getAllSaved: \($0)")
        }.onError { err in
            print("ERR getAllSaved: \(err)")
        }.onCacheSuccess {
            print("CACHE \($0)")
        }

        rep.getCityBy(name: "Воронеж").onCompleted { res in
            print("RES GET CITY BY NAME: \(res)")

            rep.save(city: res).onCompleted {
                print("SAVED SUCCESSFULLY")
            }.onError { err in
                print("ERROR WHILE SAVE \(err)")
            }
        }.onError { err in
            print("ERR: \(err)")
        }

        return [
            LaunchingApplicationService(),
            self.coreDataInitService
        ]
    }

}

// MARK: - PersistenceCoordinatorProvider

extension AppDelegate: PersistenceCoordinatorProvider {
    func get() -> NSPersistentContainer {
        self.coreDataInitService.persistenceContainer
    }
}
