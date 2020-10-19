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
        let (view, output) = AddCityModuleConfigurator().configure()

        output.didGetCity = { [weak self] city in
            self?.router.dismissModule(animated: true) { [weak self] in
                // FIXME: Добавить навигацию на список
                print(city)
            }
        }

        output.didDismiss = { [weak self] in
            self?.router.dismissModule()
        }

        router.present(ModalNavigationController(rootViewController: view))
    }

    func showCitiesList() {
        let (view, output) = CitiesListModuleConfigurator().configure()

        output.didAddCity = { [weak self] in
            self?.showAddCity()
        }

        output.didSelectCity = { [weak self] city in
            print(city)
            // TODO: show cpecific city
        }

        router.setRootModule(view)
    }
}
