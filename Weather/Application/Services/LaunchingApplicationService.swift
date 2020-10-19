import PluggableApplicationDelegate

final class LaunchingApplicationService: NSObject, ApplicationService {

    // MARK: - Private Properties

    private lazy var appCoordinator = ApplicationCoordinator()

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
        self.window?.rootViewController = UIViewController()
        self.window?.makeKeyAndVisible()
        self.appCoordinator.start()
    }
}
