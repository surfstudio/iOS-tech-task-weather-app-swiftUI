//
//  DetailModuleConfigurator.swift
//  Weather
//

import SurfUtils
import CoreLocation

final class DetailModuleConfigurator {

    // MARK: - Internal methods

    func configure() -> (DetailViewController, DetailModuleInput, DetailModuleOutput) {
        guard let view = UIStoryboard(name: String(describing: DetailViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? DetailViewController else {
            fatalError("Can't load MainViewController from storyboard, check that controller is initial view controller")
        }
        let presenter = DetailPresenter(repository: CityCacheRepositoryFactory().produce(),
                                        geoService: GeolocationService(manager: CLLocationManager(),
                                                                       accuracy: .threeKilometers))

        presenter.view = view
        view.output = presenter

        return (view, presenter, presenter)
    }
}
