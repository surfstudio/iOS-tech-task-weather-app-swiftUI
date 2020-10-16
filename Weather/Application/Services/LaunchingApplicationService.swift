//
//  Copyright © 2020 Surf. All rights reserved.
//

import PluggableApplicationDelegate

final class LaunchingApplicationService: NSObject, ApplicationService {

    // MARK: - ApplicationService

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        initializeRootView()
        return true
    }
}

// MARK: - Private methods

private extension LaunchingApplicationService {
    func initializeRootView() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = MockViewController()
        self.window?.makeKeyAndVisible()
    }
}

// FIXME: Удалить моковый контроллер

class MockViewController: UIViewController, StateConfigurable, MultiStatesPresentable, SnackDisplayable {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        set(state: .error(.init(Localized.Error.noInternetConnection, action: Localized.Common.Button.reload)))

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.showSnack(with: "Снэкабельный ошибка")
        }
    }
}
