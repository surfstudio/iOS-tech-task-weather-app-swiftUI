//
//  CitiesListViewController.swift
//  Weather
//

import UIKit

final class CitiesListViewController: UIViewController, CitiesListViewInput {

    // MARK: - Properties

    var output: CitiesListViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

    // MARK: - CitiesListViewInput

    func setupInitialState() {

    }

}
