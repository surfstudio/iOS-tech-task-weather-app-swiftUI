import UIKit

final class CititesCoordinator: BaseCoordinator {

    // MARK: - Public Properties

    var finishFlow: EmptyClosure?

    // MARK: - Private Properties

    private let router: Router

    // MARK: - Initialization

    init(router: Router) {
        self.router = router
    }

    // MARK: - BaseCoordinator

    override func start() {
        super.start()
        // FIXME: Поменять на нужный экран
        showAddCity()
    }
}

// MARK: - Private Methods

private extension CititesCoordinator {
    func showAddCity() {
        let (view, _) = AddCityModuleConfigurator().configure()
        router.setRootModule(UINavigationController(rootViewController: view))
    }
}
