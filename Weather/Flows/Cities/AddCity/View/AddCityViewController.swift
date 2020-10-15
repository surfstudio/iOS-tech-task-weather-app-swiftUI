//
//  AddCityViewController.swift
//  Weather
//

import UIKit

final class AddCityViewController: UIViewController, AddCityViewInput {

    // MARK: - IBOutlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties

    var output: AddCityViewOutput?

    // MARK: - Private Properties

    private let searchController = UISearchController(searchResultsController: nil)

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureAppearance()
        output?.viewLoaded()
    }

    // MARK: - AddCityViewInput

    func setupInitialState() {

    }
}

// MARK: -

extension AddCityViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

    }
}

// MARK: - Private methods

private extension AddCityViewController {
    func configureAppearance() {
    }

    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Искать"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}
