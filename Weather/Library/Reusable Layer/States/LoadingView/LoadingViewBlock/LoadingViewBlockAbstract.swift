import UIKit

protocol LoadingViewBlockAbstract {
    var repeatCount: Int { get }
    func getSubviews() -> [LoadingSubviewAbstract]
    func configure(color: UIColor)
    func reconfigure(repeatCount: Int) -> Self
}
