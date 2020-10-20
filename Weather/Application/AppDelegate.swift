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

    fileprivate static var coreDataInitService = CoreDataIntApplicationService(repo: CityCacheRepositoryFactory().produce())

    override var services: [ApplicationService] {
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
