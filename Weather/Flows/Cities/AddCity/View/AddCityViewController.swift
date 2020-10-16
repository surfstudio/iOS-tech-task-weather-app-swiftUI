//
//  AddCityViewController.swift
//  Weather
//

import ReactiveDataDisplayManager

final class AddCityViewController: UIViewController, AddCityViewInput {

    // MARK: - IBOutlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties

    var output: AddCityViewOutput?

    // MARK: - Private Properties

    private let searchController = UISearchController(searchResultsController: nil)
    private lazy var ddm = BaseTableDataDisplayManager(collection: tableView)
    private let emptyLabel = UILabel()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureEmptyLabel()
        configureSearchController()
        configureAppearance()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.isActive = true

    }

    // MARK: - AddCityViewInput

    func update(citites: [PlacesSuggestionEntity]) {
        hideEmptyState()
        ddm.clearCellGenerators()

        citites.forEach { city in
            // FIXME: Поменять title и subtitle
            let generator = BaseCellGenerator<AddCityCell>(with: (title: city.displayName,
                                                                  subtitle: city.displayName))

            generator.didSelectEvent += { [weak self] in
                self?.output?.didSelect(city: city)
            }

            ddm.addCellGenerator(generator)
        }

        ddm.forceRefill()
    }
}

// MARK: - MultiStatesPresentable

extension AddCityViewController: MultiStatesPresentable {
    func performErrorStateAction() {
        output?.didSearch(query: searchController.searchBar.text ?? "")
    }

    func performEmptyStateAction() {
        output?.didSearch(query: searchController.searchBar.text ?? "")
    }

    func showErrorView(message: String, action: String, _ callback: EmptyClosure?) {
        showEmptyState(with: message)
    }

    func showEmptyView(message: String, action: String, _ callback: EmptyClosure?) {
        showEmptyState(with: message)
    }

    func hideErrorView() {
        hideEmptyState()
    }

    func hideEmptyView() {
        hideEmptyState()
    }
}

// MARK: - UISearchResultsUpdating

extension AddCityViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        output?.didSearch(query: searchController.searchBar.text ?? "")
    }
}

// MARK: - UISearchControllerDelegate

extension AddCityViewController: UISearchControllerDelegate {
    func presentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
}

// MARK: - UISearchControllerDelegate

extension AddCityViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        output?.didCancelTap()
    }
}

// MARK: - Private methods

private extension AddCityViewController {
    func configureAppearance() {
        view.backgroundColor = Asset.Color.lightGrey.color
        tableView.backgroundColor = Asset.Color.lightGrey.color
        tableView.separatorStyle = .none
        searchController.searchBar.apply(style: .defaultSearchBar)
    }

    func configureSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Localized.Common.TextField.search
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func showEmptyState(with message: String) {
        emptyLabel.text = message
        emptyLabel.apply(style: .TR16BlackCenter)
        emptyLabel.isHidden = false
    }

    func hideEmptyState() {
        emptyLabel.text = nil
        emptyLabel.isHidden = true
    }

    func configureEmptyLabel() {
        emptyLabel.isHidden = true
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(emptyLabel)

        NSLayoutConstraint.activate([
            emptyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 180.0),
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0)
        ])
    }
}
