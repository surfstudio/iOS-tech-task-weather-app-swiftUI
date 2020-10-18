//
//  MainTemperatureCell.swift
//  Weather
//

import ReactiveDataDisplayManager

final class MainTemperatureCell: UITableViewCell {

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

extension MainTemperatureCell: Configurable {
    func configure(with model: CityDetailedWeatherEntity) {
        temperatureLabel.text = "21°"
        temperatureLabel.apply(style: .DB100WhiteCenter)
        temperatureTypeLabel.apply(style: .TM18WhiteCenter)
        temperatureMinMaxLabel.text = ""
        temperatureMinMaxLabel.apply(style: .TR14WhiteCenter)
    }
}

// MARK: - Private Methods

private extension MainTemperatureCell {
    func configureAppearance() {
        selectionStyle = .none
        backgroundColor = .clear
    }
}
