//
//  CitiesListModuleConfigurator.swift
//  Weather
//

import UIKit

final class CitiesListModuleConfigurator {

    // MARK: - Internal methods

    func configure() -> (CitiesListViewController, CitiesListModuleOutput) {
        guard let view = UIStoryboard(name: String(describing: CitiesListViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? CitiesListViewController else {
            fatalError("Can't load CitiesListViewController from storyboard, check that controller is initial view controller")
        }
        let presenter = CitiesListPresenter()

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
