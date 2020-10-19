//
//  CityListCityCellGenerator.swift
//  Weather
//

import ReactiveDataDisplayManager

final class CityListCityCellGenerator: SelectableItem {

    // MARK: - SelectableItem

    var isNeedDeselect = true
    var didSelectEvent = BaseEvent<Void>()

    // MARK: - Public Properties

    var isEditing: Bool = false {
        didSet {
            view?.set(editing: isEditing)
        }
    }

    var didRemoveEvent = BaseEvent<Void>()

    // MARK: - Private Properties

    private let model: CityDetailedEntity
    private weak var view: CityListCityCell?

    // MARK: - Lifecycle

    init(model: CityDetailedEntity) {
        self.model = model
    }
}

extension CityListCityCellGenerator: CollectionCellGenerator {
    var identifier: UICollectionViewCell.Type {
        return CityListCityCell.self
    }
}

extension CityListCityCellGenerator: ViewBuilder {
    func build(view: CityListCityCell) {
        self.view = view

        view.fill(with: model)
        view.set(editing: isEditing)

        view.didRemove = { [weak self] in
            self?.didRemoveEvent.invoke(with: ())
        }
    }
}
