import Foundation

/// Координатор всего приложения. Тут можно управлять глоабльным состоянием модулей/экранов
final class ApplicationCoordinator: BaseCoordinator {

    // MARK: - Private properties

    private(set) var router = MainRouter()

    // MARK: - BaseCoordinator

    override func start() {
        super.start()
        runMainFlow(with: nil)
    }
}

// MARK: - Flows

private extension ApplicationCoordinator {
    func runMainFlow(with deepLinkOption: DeepLinkOption?) {
        let coordinator = CititesCoordinator(router: router)

        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }

        addDependency(coordinator)
        coordinator.start()
    }
}
