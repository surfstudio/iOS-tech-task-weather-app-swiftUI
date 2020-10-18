//
//  DetailHourlyTemperatureCell.swift
//  Weather
//

import ReactiveDataDisplayManager
import SurfUtils

final class DetailHourlyTemperatureCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var stackView: UIStackView!

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
}

// MARK: - Configurable

extension DetailHourlyTemperatureCell: Configurable {
    func configure(with model: DetailedWeatherEntity) {
        let hoursTillNow = model.hourly?.filter { entity in
            guard
                let date = entity.forecastDate,
                let hour = Calendar.current.dateComponents([.hour], from: date).hour,
                let currentHour = Calendar.current.dateComponents([.hour], from: Date()).hour
            else {
                return false
            }

            return hour >= currentHour
        }

        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let views = createViews(from: hoursTillNow ?? [])
        views.forEach { self.stackView.addArrangedSubview($0) }
    }
}

// MARK: - Private Methods

private extension DetailHourlyTemperatureCell {
    func configureAppearance() {
        selectionStyle = .none
        backgroundColor = .clear
        containerView.apply(style: .card)
        scrollView.showsHorizontalScrollIndicator = false

        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
    }

    func createViews(from temperatures: [DetailedHourlyWeatherEntity]) -> [UIView] {
        return temperatures.enumerated().compactMap { index, entity -> UIView? in
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .clear

            let degreesLabel = self.createLabel(text: entity.temperature?.degrees,
                                                       style: .TB18WhiteCenter)

            let imageView = self.createWeaterIconImageView(type: entity.weather?.first?.type,
                                                           day: entity.forecastDate?.isDay ?? true)

            let hourLabel: UILabel
            if index == 0 {
                hourLabel = self.createLabel(text: Localized.Detail.today,
                                             style: .TB13WhiteCenter)
            } else if let date = entity.forecastDate {
                let text = DateFormatter.with(style: .hoursAndMinutes).string(from: date)
                hourLabel = self.createLabel(text: text,
                                             style: .TR13WhiteCenter)
            } else {
                hourLabel = UILabel()
            }

            view.addSubview(degreesLabel)
            view.addSubview(imageView)
            view.addSubview(hourLabel)

            NSLayoutConstraint.activate([
                degreesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20.0),
                degreesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0),
                degreesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0),
                degreesLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -12.0),

                imageView.heightAnchor.constraint(equalToConstant: 24.0),
                imageView.widthAnchor.constraint(equalToConstant: 24.0),
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageView.bottomAnchor.constraint(equalTo: hourLabel.topAnchor, constant: -12.0),

                hourLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0),
                hourLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8.0),
                hourLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20.0)
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
