import UIKit

protocol LoadingSubviewAbstract: UIView {
    var height: CGFloat { get }

    func configure(color: UIColor)
}
