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
        showMain()
    }
}

// MARK: - Private Methods

private extension DetailCoordinator {
    func showMain() {
        let (view, output) = DetailModuleConfigurator().configure()
        router.setRootModule(UINavigationController(rootViewController: view))
    }
}
