//
//  DetailInfoTemperatureCell.swift
//  Weather
//

import ReactiveDataDisplayManager
import SurfUtils

final class DetailInfoTemperatureCell: UITableViewCell {

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

extension DetailInfoTemperatureCell: Configurable {
    func configure(with model: DetailedWeatherEntity) {
        let currentDayTemperature = model.daily?.first { entity in
            let day = Calendar.current.dateComponents([.day], from: entity.forecastDate)
            let currentDay = Calendar.current.dateComponents([.day], from: Date())

            return day == currentDay
        }

        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let leftStackView = UIStackView()
        leftStackView.axis = .vertical
        let humidity = (currentDayTemperature?.humidity ?? .zero) / 100.0
        let humidityView = createView(title: Localized.Detail.humidity,
                                      value: humidity.percent,
                                      progress: humidity)
        leftStackView.addArrangedSubview(humidityView)

        let clouds = Double((currentDayTemperature?.clouds ?? .zero)) / 100.0
        let cloudsView = createView(title: Localized.Detail.clouds,
                                    value: clouds.percent,
                                    progress: clouds)
        leftStackView.addArrangedSubview(cloudsView)

        stackView.addArrangedSubview(leftStackView)

        let rightStackView = UIStackView()
        rightStackView.axis = .vertical

        let pressureView = createView(title: Localized.Detail.pressure,
                                      value: currentDayTemperature?.pressure?.pressure)
        rightStackView.addArrangedSubview(pressureView)

        let windSpeedView = createView(title: Localized.Detail.windSpeed,
                                       value: currentDayTemperature?.windSpeed?.windSpeed)
        rightStackView.addArrangedSubview(windSpeedView)

        stackView.addArrangedSubview(rightStackView)
    }
}

// MARK: - Private Methods

private extension DetailInfoTemperatureCell {
    func configureAppearance() {
        selectionStyle = .none
        backgroundColor = .clear
        containerView.apply(style: .card)

        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
    }

    func createView(title: String?, value: String?, progress: Double) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear

        let progressBar = self.createProgressBar(progress: progress)
        let titleLabel = self.createLabel(text: title,
                                          style: .TR13White40Left)
        let valueLabel = self.createLabel(text: value,
                                          style: .TB18WhiteLeft)

        view.addSubview(progressBar)
        view.addSubview(titleLabel)
        view.addSubview(valueLabel)

        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 8.0),
            progressBar.heightAnchor.constraint(equalToConstant: 32.0),
            progressBar.widthAnchor.constraint(equalToConstant: 4.0),
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            progressBar.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -12.0),
            progressBar.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: -12.0),

            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: 8.0),
            titleLabel.topAnchor.constraint(equalTo: progressBar.topAnchor),

            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2.0),
            valueLabel.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: -8.0),
            valueLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0)
        ])

        return view
    }

    func createView(title: String?, value: String?) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear

        let titleLabel = self.createLabel(text: title,
                                          style: .TR13White40Left)
        let valueLabel = self.createLabel(text: value,
                                          style: .TB18WhiteLeft)

        view.addSubview(titleLabel)
        view.addSubview(valueLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8.0),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8.0),
            titleLabel.bottomAnchor.constraint(equalTo: valueLabel.topAnchor, constant: -4.0),

            valueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0),
            valueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8.0),
            valueLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0)
        ])

        return view
    }

    func createLabel(text: String?, style: UIStyle<UILabel>) -> UILabel {
        let degreesLabel = UILabel()
        degreesLabel.translatesAutoresizingMaskIntoConstraints = false

        degreesLabel.text = text
        degreesLabel.apply(style: style)

        return degreesLabel
    }

    func createProgressBar(progress: Double) -> ProgressBar {
        let progressBar = ProgressBar(progress: progress)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }
}
