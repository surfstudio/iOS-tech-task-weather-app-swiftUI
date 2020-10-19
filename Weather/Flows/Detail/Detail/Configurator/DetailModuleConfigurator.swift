//
//  DetailModuleConfigurator.swift
//  Weather
//

import UIKit

final class DetailModuleConfigurator {

    // MARK: - Internal methods

    func configure() -> (DetailViewController, DetailModuleOutput) {
        guard let view = UIStoryboard(name: String(describing: DetailViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? DetailViewController else {
            fatalError("Can't load MainViewController from storyboard, check that controller is initial view controller")
        }
        let presenter = DetailPresenter(service: DetailedWeatherNetworkService())

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }
}
