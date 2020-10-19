import UIKit

final class DetailCoordinator: BaseCoordinator {

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
//        showMain()
        // TODO: Show Right Screen
        showCitiesList()
    }
}

// MARK: - Private Methods

private extension DetailCoordinator {
    func showMain() {
        let (view, output) = DetailModuleConfigurator().configure()
        router.setRootModule(UINavigationController(rootViewController: view))
    }

    func showCitiesList() {
        let coordinator = CititesCoordinator(router: self.router)

        self.addDependency(coordinator)

        coordinator.finishFlow = { [weak self] in
            self?.removeDependency(coordinator)
        }

        coordinator.start()
    }

}
