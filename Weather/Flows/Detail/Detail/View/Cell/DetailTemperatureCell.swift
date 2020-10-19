//
//  DetailTemperatureCell.swift
//  Weather
//

import ReactiveDataDisplayManager

final class DetailTemperatureCell: UITableViewCell {

    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var temperatureIconImageView: UIImageView!
    @IBOutlet private weak var temperatureTypeLabel: UILabel!
    @IBOutlet private weak var temperatureMinMaxLabel: UILabel!

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
}

// MARK: - Configurable

extension DetailTemperatureCell: Configurable {
    func configure(with model: (weather: DetailedWeatherEntity, time: Date?)) {
        let currentHourTemperature = model.weather.hourly?.first { entity in
            guard let date = entity.forecastDate else { return false }
            let hour = Calendar.current.dateComponents([.hour], from: date)
            let currentHour = Calendar.current.dateComponents([.hour], from: Date())

            return hour == currentHour
        }

        temperatureLabel.text = currentHourTemperature?.temperature?.degrees
        temperatureLabel.apply(style: .DB100WhiteCenter)

        temperatureIconImageView.image = currentHourTemperature?.weather?.first?.type.weatherAsset(for: model.time).image

        temperatureTypeLabel.text = currentHourTemperature?.weather?.first?.description
        temperatureTypeLabel.apply(style: .TM18WhiteCenter)

        let currentDayTemperature = model.weather.daily?.first { entity in
            let day = Calendar.current.dateComponents([.day], from: entity.forecastDate)
            let currentDay = Calendar.current.dateComponents([.day], from: Date())

            return day == currentDay
        }

        if let min = currentDayTemperature?.temperature?.min,
           let max = currentDayTemperature?.temperature?.max {

            temperatureMinMaxLabel.text = Localized.Detail.maxmin(Float(max), Float(min))
            temperatureMinMaxLabel.apply(style: .TR14WhiteCenter)
        }
    }
}

// MARK: - Private Methods

private extension DetailTemperatureCell {
    func configureAppearance() {
        selectionStyle = .none
        backgroundColor = .clear
    }
}
