//
//  MainCell.swift
//  Weather
//

import ReactiveDataDisplayManager

final class MainCell: UICollectionViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Private Properties

    private lazy var ddm = BaseTableDataDisplayManager(collection: tableView)

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
}

// MARK: - Configurable

extension MainCell: Configurable {
    func configure(with model: CityDetailedWeatherEntity) {
        ddm.clearCellGenerators()

        let temperatureCell = BaseCellGenerator<MainTemperatureCell>(with: model)
        ddm.addCellGenerator(temperatureCell)

        ddm.forceRefill()
    }
}

// MARK: - Private Methods

private extension MainCell {
    func configureAppearance() {
        tableView.separatorStyle = .none
    }
}
