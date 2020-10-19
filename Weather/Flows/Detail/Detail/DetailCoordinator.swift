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
        showDetail()
    }
}

// MARK: - Private Methods

private extension DetailCoordinator {
    func showDetail() {
        let (view, input, output) = DetailModuleConfigurator().configure()

        output.didShowCities = { [weak self, weak input] in
            // FIXME - Добавить переход к городам
        }

        router.setRootModule(UINavigationController(rootViewController: view))
    }
}
