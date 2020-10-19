//
//  AddCityModuleConfigurator.swift
//  Weather
//

import UIKit

final class AddCityModuleConfigurator {

    // MARK: - Internal methods

    func configure() -> (AddCityViewController, AddCityModuleOutput) {
        guard let view = UIStoryboard(name: String(describing: AddCityViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? AddCityViewController else {
            fatalError("Can't load AddCityViewController from storyboard, check that controller is initial view controller")
        }
        let presenter = AddCityPresenter(geoService: GeocodingNetworkService(),
                                         cityService: CityNetworkService(),
                                         repo: CityCacheRepositoryFactory().produce())

        presenter.view = view
        view.output = presenter

        return (view, presenter)
    }

}
