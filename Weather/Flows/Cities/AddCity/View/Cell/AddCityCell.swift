//
//  AddCityCell.swift
//  Weather
//

import ReactiveDataDisplayManager

final class AddCityCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var separatorView: UIView!

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
}

// MARK: - Configurable

extension AddCityCell: Configurable {
    func configure(with model: (title: String, subtitle: String)) {
        titleLabel.text = model.title
        titleLabel.apply(style: .TS16BlackLeft)

        subtitleLabel.text = model.subtitle
        subtitleLabel.apply(style: .TR15GreyLeft)
    }
}

// MARK: - Private Methods

private extension AddCityCell {
    func configureAppearance() {
        backgroundColor = Asset.Color.lightGrey.color
        separatorView.apply(style: .separator)
    }
}
