//
//  CitiesListViewController.swift
//  Weather
//

import UIKit
import ReactiveDataDisplayManager

final class CitiesListViewController: UIViewController, CitiesListViewInput {

    // MARK: - IBOutlets

    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - Properties

    private lazy var ddm = BaseCollectionDataDisplayManager(collection: self.collectionView)

    var output: CitiesListViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
        self.configureAppearence()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.apply(style: .blackTitleNavigationBar)
    }

    // MARK: - CitiesListViewInput

    func setupInitialState() {
        let layout = UICollectionViewFlowLayout()
        let dimension: CGFloat = UIScreen.main.bounds.width / 2.0 - 32.0
        layout.itemSize = .init(width: dimension, height: dimension)
        layout.minimumLineSpacing = 16.0
        layout.minimumInteritemSpacing = 16.0
        layout.sectionInset = .init(top: 24.0, left: 24.0, bottom: 24.0, right: 24.0)
        self.collectionView.collectionViewLayout = layout
    }

    func show(cities: [CityDetailedEntity]) {
        let gens = cities.map { city -> BaseCollectionCellGenerator<CityListCityCell> in
            let gen = BaseCollectionCellGenerator<CityListCityCell>(with: city)
            gen.didSelectEvent += { [weak self] in
                self?.output?.didSelect(city: city)
            }
            return gen
        }
        self.ddm.clearCellGenerators()
        let addCellGenerator = BaseCollectionCellGenerator<CityListAddCityCell>(with: (), registerClass: true)

        addCellGenerator.didSelectEvent += { [weak self] in
            self?.output?.didAddCitySelected()
        }
        self.ddm.addCellGenerator(addCellGenerator)
        self.ddm.addCellGenerators(gens)
        self.ddm.forceRefill()
    }

}

// MARK: - Configure Appearence

private extension CitiesListViewController {
    func configureAppearence() {
        self.view.backgroundColor = Asset.Color.white.color
        self.collectionView.backgroundColor = Asset.Color.white.color
        self.collectionView.showsVerticalScrollIndicator = false
    }
}
