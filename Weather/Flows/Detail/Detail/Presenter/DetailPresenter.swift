//
//  DetailPresenter.swift
//  Weather
//

final class DetailPresenter: DetailViewOutput, DetailModuleInput, DetailModuleOutput {

    // MARK: - DetailModuleOutput

    // MARK: - Properties

    weak var view: DetailViewInput?

    // MARK: - Private Properties

    private let service: DetailedWeatherService

    // MARK: - Lifecycle

    init(service: DetailedWeatherService) {
        self.service = service
    }

    // MARK: - DetailViewOutput

    func viewLoaded() {
        loadWeather()
    }

    func didReload() {
        loadWeather()
    }

    // MARK: - DetailModuleInput

}

// MARK: - Private Methods

private extension DetailPresenter {
    func loadWeather() {
        view?.setupInitialState(weather: .init(daily: nil, hourly: nil, minutely: nil))
    }
}
