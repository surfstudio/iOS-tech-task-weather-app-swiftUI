//
//  DetailViewController.swift
//  Weather
//

import ReactiveDataDisplayManager

final class DetailViewController: UIViewController, DetailViewInput {

    // MARK: - IBOutlets

    @IBOutlet private weak var backgroundImageView: UIImageView!
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
        setBackground(weather: weather)

        ddm.clearCellGenerators()

        let currentGenerator = BaseCellGenerator<DetailTemperatureCell>(with: weather)
        ddm.addCellGenerator(currentGenerator)

        let hourlyGenerator = BaseCellGenerator<DetailHourlyTemperatureCell>(with: weather)
        ddm.addCellGenerator(hourlyGenerator)

        let dailyGenerator = BaseCellGenerator<DetailDailyTemperatureCell>(with: weather)
        ddm.addCellGenerator(dailyGenerator)

        let infoGenerator = BaseCellGenerator<DetailInfoTemperatureCell>(with: weather)
        ddm.addCellGenerator(infoGenerator)

        let minutelyGenerator = BaseCellGenerator<DetailMinutelyTemperatureCell>(with: weather)
        ddm.addCellGenerator(minutelyGenerator)

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
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false

        backgroundImageView.image = Asset.Image.Background.fog.image
        backgroundImageView.contentMode = .scaleAspectFill
    }

    func setBackground(weather: DetailedWeatherEntity) {
        let currentHourTemperature = weather.hourly?.first { entity in
            guard let date = entity.forecastDate else { return false }
            let hour = Calendar.current.dateComponents([.hour], from: date)
            let currentHour = Calendar.current.dateComponents([.hour], from: Date())

            return hour == currentHour
        }

        backgroundImageView.image = currentHourTemperature?.weather?.first?.type.backgroundAsset.image
    }
}
