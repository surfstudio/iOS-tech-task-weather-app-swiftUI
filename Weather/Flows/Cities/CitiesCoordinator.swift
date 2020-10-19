import UIKit

final class CititesCoordinator: BaseCoordinator {

    // MARK: - Public Properties

    var finishFlow: Closure<CityDetailedEntity>?

    // MARK: - Private Properties

    private let router: Router

    // MARK: - Initialization

    init(router: Router) {
        self.router = router
    }

    // MARK: - BaseCoordinator

    override func start() {
        super.start()
        showCitiesList()
    }
}

// MARK: - Private Methods

private extension CititesCoordinator {
    func showAddCity() {
        let (view, output) = AddCityModuleConfigurator().configure()

        output.didGetCity = { [weak self] city in
            self?.router.dismissModule(animated: true) { [weak self] in
                self?.router.dismissModule(animated: true) { [weak self] in
                    self?.router.popModule()
                    self?.finishFlow?(city)
                }
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
            self?.router.popModule()
            self?.finishFlow?(city)
        }

        router.push(view)
    }
}
