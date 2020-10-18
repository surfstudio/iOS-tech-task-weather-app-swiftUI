//
//  DetailViewController.swift
//  Weather
//

import ReactiveDataDisplayManager

final class DetailViewController: UIViewController, DetailViewInput {

    // MARK: - IBOutlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Public Properties

    var output: DetailViewOutput?

    // MARK: - Private Properties

    private lazy var ddm = BaseTableDataDisplayManager(collection: tableView)

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        output?.viewLoaded()
    }

    // MARK: - DetailViewInput

    func setupInitialState(weather: DetailedWeatherEntity) {
        ddm.clearCellGenerators()

        let dailyGenerator = BaseCellGenerator<DetailTemperatureCell>(with: weather)
        ddm.addCellGenerator(dailyGenerator)

        let hourlyGenerator = BaseCellGenerator<DetailHourlyTemperatureCell>(with: weather)
        ddm.addCellGenerator(hourlyGenerator)

        ddm.forceRefill()
    }
}

// MARK: - MultiStatesPresentable

extension DetailViewController: MultiStatesPresentable {
    func performErrorStateAction() {
        output?.didReload()
    }

    func performEmptyStateAction() {
        output?.didReload()
    }
}

// MARK: - Private Methods

private extension DetailViewController {
    func configureAppearance() {
        navigationController?.navigationBar.apply(style: .clearNavigationBar)
        tableView.separatorStyle = .none
        // FIXME - Добавить фон
        view.backgroundColor = .red
        tableView.backgroundColor = .red
    }
}
