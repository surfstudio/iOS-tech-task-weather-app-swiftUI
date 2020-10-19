//
//  CityCell.swift
//  UnitTests
//
//  Created by Александр Кравченков on 19.10.2020.
//

import Foundation
import ReactiveDataDisplayManager

final class CityListCityCell: UICollectionViewCell, SelectableItem {

    // MARK: - IBOutlets

    @IBOutlet private weak var backgroundImage: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var weatherImage: UIImageView!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!

    // MARK: - Events

    var didSelectEvent = BaseEvent<Void>()

    // MARK: - UICollectionViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureAppearence()
    }

    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            super.isHighlighted = newValue
            self.contentView.alpha = newValue ? 0.5 : 1
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundImage.addParalax(with: 10)
    }
}

// MARK: - Configurable

extension CityListCityCell: Configurable {
    func configure(with model: CityDetailedEntity) {
        if let temperature = model.main?.temperature {
            self.temperatureLabel.isHidden = false
            self.temperatureLabel.text = L10n.List.Cells.City.temperature(Float(temperature))
            self.temperatureLabel.apply(style: .TR28WhiteLeft)
        } else {
            self.temperatureLabel.isHidden = true
        }

        if let type = model.weather?.first?.type {
            self.weatherImage.isHidden = false
            self.weatherImage.image = type.weatherAsset(for: model.time).image
            self.backgroundImage.image = type.backgroundAsset.image
        } else {
            self.weatherImage.isHidden = true
            self.backgroundImage.image = WeatherType.clear.backgroundAsset.image
        }

        if let country = model.systemInfo?.country,
           let string = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: country) {

            self.countryLabel.isHidden = false
            self.countryLabel.text = string
            self.countryLabel.apply(style: .TB18WhiteLeft)
        } else {
            self.countryLabel.isHidden = true
        }

        if let city = model.cityName {
            self.cityLabel.isHidden = false
            self.cityLabel.text = city
            self.countryLabel.apply(style: .TR14WhiteLeft)
        } else {
            self.cityLabel.isHidden = true
        }

        self.setNeedsLayout()
    }
}

// MARK: - Configure Appearence

private extension CityListCityCell {
    func configureAppearence() {
        self.backgroundColor = Asset.Color.white.color
        self.layer.cornerRadius = 18
        self.backgroundImage.layer.cornerRadius = 18
    }
}
