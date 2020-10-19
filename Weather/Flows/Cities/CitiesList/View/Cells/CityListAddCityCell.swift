//
//  AddCityCell.swift
//  Weather
//
//  Created by Александр Кравченков on 19.10.2020.
//

import UIKit
import ReactiveDataDisplayManager

final class CityListAddCityCell: UICollectionViewCell, SelectableItem {

    // MARK: - Events

    var didSelectEvent = BaseEvent<Void>()

    // MARK: - Properties

    lazy var plusImage = UIImageView()
    lazy var titleLabel = UILabel()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layoutContent()
        self.configureAppearence()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layoutContent()
        self.configureAppearence()
    }

    // MARK: - UICollectionViewCell

    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            super.isHighlighted = newValue

            let alpha: CGFloat = newValue ? 0.5 : 1
            self.contentView.alpha = alpha
            self.titleLabel.alpha = alpha
            self.plusImage.alpha = alpha
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.addParalax(with: 10)
    }
}

extension CityListAddCityCell: Configurable {
    func configure(with model: Void) {
        self.setNeedsLayout()
    }
}

// MARK: - Configure Appearence

private extension CityListAddCityCell {

    func layoutContent() {
        self.contentView.addSubview(self.plusImage)
        self.contentView.addSubview(self.titleLabel)

        self.plusImage.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.plusImage.widthAnchor.constraint(equalToConstant: 24),
            self.plusImage.heightAnchor.constraint(equalToConstant: 24),
            self.plusImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.plusImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -16.0),

            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -14),
            self.titleLabel.topAnchor.constraint(equalTo: self.plusImage.bottomAnchor, constant: 12)
        ])
    }

    func configureAppearence() {
        self.contentView.backgroundColor = Asset.Color.darkGrey.color
        self.backgroundColor = Asset.Color.white.color
        self.plusImage.image = Asset.Image.Utils.plus.image
        self.titleLabel.text = L10n.List.Cells.AddCity.title
        self.titleLabel.apply(style: .TR16WhiteCenter)
        self.contentView.layer.cornerRadius = 18
        self.layer.cornerRadius = 18
    }
}
