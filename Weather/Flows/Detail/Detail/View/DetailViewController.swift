//
//  DetailViewController.swift
//  Weather
//

import ReactiveDataDisplayManager
import SurfUtils

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewWillAppear()
    }

    // MARK: - DetailViewInput

    func setupInitialState(weather: CityDetailedEntity) {
        navigationItem.title = weather.cityName

        guard let detailedWeather = weather.detailedWeather else { return }

        setBackground(weather: detailedWeather)

        ddm.clearCellGenerators()

        let currentGenerator = BaseCellGenerator<DetailTemperatureCell>(with: (weather: detailedWeather, time: weather.time))
        ddm.addCellGenerator(currentGenerator)

        let hourlyGenerator = BaseCellGenerator<DetailHourlyTemperatureCell>(with: (weather: detailedWeather, time: weather.time))
        ddm.addCellGenerator(hourlyGenerator)

        let dailyGenerator = BaseCellGenerator<DetailDailyTemperatureCell>(with: detailedWeather)
        ddm.addCellGenerator(dailyGenerator)

        let infoGenerator = BaseCellGenerator<DetailInfoTemperatureCell>(with: detailedWeather)
        ddm.addCellGenerator(infoGenerator)

        let minutelyGenerator = BaseCellGenerator<DetailMinutelyTemperatureCell>(with: detailedWeather)
        ddm.addCellGenerator(minutelyGenerator)

        ddm.forceRefill()
    }

    func set(navigationBarStyle: UIStyle<UINavigationBar>) {
        navigationController?.navigationBar.apply(style: navigationBarStyle)
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
        navigationItem.leftBarButtonItem = .init(image: Asset.Image.NavigationItem.list.image,
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(tapOnList))

        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false

        backgroundImageView.contentMode = .scaleAspectFill
    }

    func setBackground(weather: DetailedWeatherEntity) {
        let currentHourTemperature = weather.hourly?.first { entity in
            guard let date = entity.forecastDate else { return false }
            let hour = Calendar.current.dateComponents([.hour], from: date)
            let currentHour = Calendar.current.dateComponents([.hour], from: Date())

            return hour == currentHour
        }

        self.backgroundImageView.image = currentHourTemperature?.weather?.first?.type.backgroundAsset.image
    }

    @objc
    func tapOnList() {
        output?.didTapOnList()
    }
}
