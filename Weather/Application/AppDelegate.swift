//
//  Copyright © 2020 Surf. All rights reserved.
//

import PluggableApplicationDelegate
import UIKit

@UIApplicationMain
class AppDelegate: PluggableApplicationDelegate {

    // MARK: - Properties

    override var services: [ApplicationService] {
        DetailedWeatherNetworkService().getDetailedWeather(by: .init(lon: 100, lat: 100)).onCompleted {
            print($0)
        }
        return [
            LaunchingApplicationService()
        ]
    }

}
