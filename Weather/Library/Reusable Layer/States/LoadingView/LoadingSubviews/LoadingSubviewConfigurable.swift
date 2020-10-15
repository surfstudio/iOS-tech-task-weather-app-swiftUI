import UIKit

protocol LoadingSubviewConfigurable: UIView {
    associatedtype Model

    func configure(model: Model)
}

extension LoadingSubviewConfigurable where Model == DefaultLoadingModel {

    func configure(model: Model) { }
}
