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

    var output: CitiesListViewOutput?

    // MARK: - Private Properties

    private lazy var ddm = CollectionDataDisplayManager(collection: self.collectionView)
    private var generators: [CityListCityCellGenerator] = []

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureAppearence()
        output?.viewLoaded()
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
        let gens = cities.map { city -> CityListCityCellGenerator in
            let gen = CityListCityCellGenerator(model: city)

            gen.didSelectEvent += { [weak self] in
                self?.output?.didSelect(city: city)
            }

            gen.didRemoveEvent += { [weak self] in
                self?.output?.didRemove(city: city)
                self?.ddm.remove(gen)
            }

            return gen
        }
        self.generators = gens
        self.ddm.clearCellGenerators()
        let addCellGenerator = BaseCollectionCellGenerator<CityListAddCityCell>(with: (), registerClass: true)

        addCellGenerator.didSelectEvent += { [weak self] in
            guard !(self?.isEditing ?? false) else { return }
            self?.output?.didAddCitySelected()
        }
        self.ddm.addCellGenerator(addCellGenerator)
        self.ddm.addCellGenerators(gens)
        self.ddm.forceRefill()
    }

}

// MARK: - MultiStatesPresentable

extension CitiesListViewController: MultiStatesPresentable {
    func performErrorStateAction() {
        output?.didReload()
    }

    func performEmptyStateAction() {
        output?.didReload()
    }
}

// MARK: - Configure Appearence

private extension CitiesListViewController {
    func configureAppearence() {
        self.navigationItem.title = Localized.List.title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: Localized.Common.Button.edit,
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(tapOnEdit))
        self.view.backgroundColor = Asset.Color.white.color
        self.collectionView.backgroundColor = Asset.Color.white.color
        self.collectionView.showsVerticalScrollIndicator = false
    }

    @objc
    func tapOnEdit() {
        isEditing.toggle()
        changeState()
    }

    func changeState() {
        if isEditing {
            generators.forEach { $0.isEditing = true }
            setEditButton(title: Localized.Common.Button.done)
        } else {
            generators.forEach { $0.isEditing = false }
            setEditButton(title: Localized.Common.Button.edit)
        }
    }

    func setEditButton(title: String) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: title,
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(tapOnEdit))
    }
}
