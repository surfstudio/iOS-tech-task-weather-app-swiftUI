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
    func configure(with model: DetailedWeatherEntity) {
        // FIXME - Удалить моки
        temperatureLabel.text = "21°"
        temperatureLabel.apply(style: .DB100WhiteCenter)

        temperatureIconImageView.image = Asset.Image.Weather.cloud.image

        temperatureTypeLabel.text = "Малооблачно"
        temperatureTypeLabel.apply(style: .TM18WhiteCenter)

        temperatureMinMaxLabel.text = "Макс. 21°, мин.  11°"
        temperatureMinMaxLabel.apply(style: .TR14WhiteCenter)
    }
}

// MARK: - Private Methods

private extension DetailTemperatureCell {
    func configureAppearance() {
        selectionStyle = .none
        backgroundColor = .clear
    }
}
