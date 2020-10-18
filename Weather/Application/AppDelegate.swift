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
        DetailedWeatherNetworkService().getDetailedWeather(by: .init(lon: 0, lat: 0)).onError {
            print("### \($0)")
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
