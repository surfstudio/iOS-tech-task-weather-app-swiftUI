//
//  RDDM+Collection.swift
//  Weather
//

import ReactiveDataDisplayManager

final class CollectionDataDisplayManager: BaseCollectionDataDisplayManager {
    func remove(_ generator: CollectionCellGenerator) {
        guard let index = self.findGenerator(generator) else { return }
        self.removeGenerator(with: index)
    }

    private func removeGenerator(with index: (sectionIndex: Int, generatorIndex: Int)) {
        guard let collection = self.collectionView else { return }

        var newGens = cellGenerators[index.sectionIndex]
        newGens.remove(at: index.generatorIndex)
        clearCellGenerators()
        addCellGenerators(newGens)

        let indexPath = IndexPath(row: index.generatorIndex, section: index.sectionIndex)
        collection.deleteItems(at: [indexPath])
    }

    private func findGenerator(_ generator: CollectionCellGenerator) -> (sectionIndex: Int, generatorIndex: Int)? {
        for (sectionIndex, section) in cellGenerators.enumerated() {
            if let generatorIndex = section.firstIndex(where: { $0 === generator }) {
                return (sectionIndex, generatorIndex)
            }
        }
        return nil
    }
}
