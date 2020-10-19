//
//  DetailDailyTemperatureCell.swift
//  Weather
//

import ReactiveDataDisplayManager
import SurfUtils

final class DetailDailyTemperatureCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var stackView: UIStackView!

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
}

// MARK: - Configurable

extension DetailDailyTemperatureCell: Configurable {
    func configure(with model: DetailedWeatherEntity) {
        let daysAfterNow = model.daily?.filter { entity in
            guard
                let day = Calendar.current.dateComponents([.day], from: entity.forecastDate).day,
                let currentDay = Calendar.current.dateComponents([.day], from: Date()).day
            else {
                return false
            }

            return day > currentDay
        }

        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let views = createViews(from: daysAfterNow ?? [])
        views.forEach { self.stackView.addArrangedSubview($0) }
    }
}

// MARK: - Private Methods

private extension DetailDailyTemperatureCell {
    func configureAppearance() {
        selectionStyle = .none
        backgroundColor = .clear
        containerView.apply(style: .card)

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
    }

    func createViews(from temperatures: [DetailedDailyWeatherEntity]) -> [UIView] {
        return temperatures.compactMap { entity -> UIView? in
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .clear

            let day = DateFormatter.with(style: .dayName).string(from: entity.forecastDate)
            let dayLabel = self.createLabel(text: day, style: .TM16WhiteLeft)

            let imageView = self.createWeaterIconImageView(type: entity.weather?.first?.type,
                                                           day: true)

            let maxLabel = self.createLabel(text: entity.temperature?.max?.degrees,
                                            style: .TB18WhiteRight)

            let minLabel = self.createLabel(text: entity.temperature?.min?.degrees,
                                            style: .TB18White40Right)

            view.addSubview(dayLabel)
            view.addSubview(imageView)
            view.addSubview(maxLabel)
            view.addSubview(minLabel)

            NSLayoutConstraint.activate([
                dayLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8.0),
                dayLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0),
                dayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0),
                dayLabel.trailingAnchor.constraint(lessThanOrEqualTo: imageView.leadingAnchor, constant: 8.0),

                imageView.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 24.0),
                imageView.widthAnchor.constraint(equalToConstant: 24.0),
                imageView.trailingAnchor.constraint(equalTo: maxLabel.leadingAnchor, constant: -4.0),

                maxLabel.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor),
                maxLabel.trailingAnchor.constraint(equalTo: minLabel.leadingAnchor, constant: -4.0),
                maxLabel.widthAnchor.constraint(equalToConstant: 44.0),

                minLabel.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor),
                minLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0),
                minLabel.widthAnchor.constraint(equalToConstant: 44.0)
            ])

            return view
        }
    }

    func createLabel(text: String?, style: UIStyle<UILabel>) -> UILabel {
        let degreesLabel = UILabel()
        degreesLabel.translatesAutoresizingMaskIntoConstraints = false

        degreesLabel.text = text
        degreesLabel.apply(style: style)

        return degreesLabel
    }

    func createWeaterIconImageView(type: WeatherType?, day: Bool) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        if day {
            imageView.image = type?.dayAsset.image
        } else {
            imageView.image = type?.nightAsset.image
        }

        return imageView
    }
}
