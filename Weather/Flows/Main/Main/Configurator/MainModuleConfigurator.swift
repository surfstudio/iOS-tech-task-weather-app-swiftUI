//
//  MainModuleConfigurator.swift
//  Weather
//

import UIKit

final class MainModuleConfigurator {

    // MARK: - Internal methods

    func configure() -> (MainViewController, MainModuleOutput) {
        guard let view = UIStoryboard(name: String(describing: MainViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? MainViewController else {
            fatalError("Can't load MainViewController from storyboard, check that controller is initial view controller")
        }
        let presenter = MainPresenter(service: CityNetworkService())

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
