//
//  MainViewController.swift
//  Weather
//

import ReactiveDataDisplayManager

final class MainViewController: UIViewController, MainViewInput {

    // MARK: - IBOutlets

    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - Public Properties

    var output: MainViewOutput?

    // MARK: - Private Properties

    private lazy var ddm = BaseCollectionDataDisplayManager(collection: collectionView)

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        configureCollectionLayout()
        output?.viewLoaded()
    }

    // MARK: - MainViewInput

    func setupInitialState(citites: [CityDetailedWeatherEntity]) {
        ddm.clearCellGenerators()

        citites.forEach { city in
            let generator = BaseCollectionCellGenerator<MainCell>(with: city)
            ddm.addCellGenerator(generator)
        }

        ddm.forceRefill()
    }
}

// MARK: - MultiStatesPresentable

extension MainViewController: MultiStatesPresentable {
    func performErrorStateAction() {
        output?.didReload()
    }

    func performEmptyStateAction() {
        output?.didReload()
    }
}

// MARK: - Private Methods

private extension MainViewController {
    func configureAppearance() {
        navigationController?.navigationBar.apply(style: .clearNavigationBar)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }

    func configureCollectionLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width,
                                height: collectionView.bounds.height)
        layout.sectionInset = .zero
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }
}
