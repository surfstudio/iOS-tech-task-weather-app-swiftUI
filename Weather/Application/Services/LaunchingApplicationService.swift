//
//  Copyright © 2020 Surf. All rights reserved.
//

import FirebaseCore
import PluggableApplicationDelegate

final class LaunchingApplicationService: NSObject, ApplicationService {

    // MARK: - ApplicationService

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}