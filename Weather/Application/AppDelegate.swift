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

    fileprivate static var coreDataInitService = CoreDataIntApplicationService()

    override var services: [ApplicationService] {
        let re = CityCacheRepositoryFactory().produce()
        re.getCityBy(name: "Ярославль").onCompleted {
            re.save(city: $0)
        }
        re.getCityBy(name: "Минск").onCompleted {
            re.save(city: $0)
        }
        re.getCityBy(name: "Курс").onCompleted {
            re.save(city: $0)
        }
        re.getCityBy(name: "Киров").onCompleted {
            re.save(city: $0)
        }
        re.getCityBy(name: "Вашингтон").onCompleted {
            re.save(city: $0)
        }
        return [
            LaunchingApplicationService(),
            AppDelegate.coreDataInitService
        ]
    }

}

// MARK: - PersistenceCoordinatorProvider

struct DefaultPCProvider: PersistenceCoordinatorProvider {
    func get() -> NSPersistentContainer {
        AppDelegate.coreDataInitService.persistenceContainer
    }
}
