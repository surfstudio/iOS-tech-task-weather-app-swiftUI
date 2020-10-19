//
//  DetailMinutelyTemperatureCell.swift
//  Weather
//

import ReactiveDataDisplayManager
import SurfUtils

final class DetailMinutelyTemperatureCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var stackView: UIStackView!

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
}

// MARK: - Configurable

extension DetailMinutelyTemperatureCell: Configurable {
    func configure(with model: DetailedWeatherEntity) {
        titleLabel.text = Localized.Detail.precipitation
        titleLabel.apply(style: .TR13White40Left)

        guard let minutely = model.sortedMinutely, !minutely.isEmpty else {
            self.stackView.isHidden = true
            return
        }

        self.stackView.isHidden = false

        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let views = createViews(from: minutely)
        views.forEach { self.stackView.addArrangedSubview($0) }
    }
}

// MARK: - Private Methods

private extension DetailMinutelyTemperatureCell {
    func configureAppearance() {
        selectionStyle = .none
        backgroundColor = .clear
        containerView.apply(style: .card)
        scrollView.showsHorizontalScrollIndicator = false

        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
    }

    func createViews(from temperatures: [DetailedMinutelyWeatherEntity]) -> [UIView] {
        return temperatures.enumerated().compactMap { index, entity -> UIView? in
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .clear

            let valueLabel = self.createLabel(text: entity.precipitation.precipitation,
                                              style: .TB18CyanCenter)

            let time = DateFormatter.with(style: .hoursAndMinutes).string(from: entity.forecastDate)

            let hourLabel: UILabel
            if index == 0 {
                hourLabel = self.createLabel(text: time, style: .TB13WhiteCenter)
            } else {
                hourLabel = self.createLabel(text: time, style: .TR13WhiteCenter)
            }

            view.addSubview(valueLabel)
            view.addSubview(hourLabel)

            NSLayoutConstraint.activate([
                valueLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8.0),
                valueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0),
                valueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0),
                valueLabel.bottomAnchor.constraint(equalTo: hourLabel.topAnchor, constant: -12.0),

                hourLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0),
                hourLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12.0),
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
}
