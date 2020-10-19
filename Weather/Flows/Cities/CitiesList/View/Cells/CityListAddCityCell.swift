//
//  AddCityCell.swift
//  Weather
//
//  Created by Александр Кравченков on 19.10.2020.
//

import UIKit
import ReactiveDataDisplayManager

final class CityListAddCityCell: UITableViewCell {
    lazy var plusImage = UIImageView()
    lazy var titleLabel = UILabel()
}

// MARK: - Configure Appearence

private extension CityListAddCityCell {
    func configureAppearence() {
        self.backgroundColor = Asset.Color.darkGrey.color
    }
}
