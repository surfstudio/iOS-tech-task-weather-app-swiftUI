//
//  AddCityPresenter.swift
//  Weather
//

final class AddCityPresenter: AddCityViewOutput, AddCityModuleInput, AddCityModuleOutput {

    // MARK: - AddCityModuleOutput

    // MARK: - Properties

    weak var view: AddCityViewInput?

    // MARK: - AddCityViewOutput

    func viewLoaded() {
        view?.setupInitialState()
    }

    // MARK: - AddCityModuleInput

}
