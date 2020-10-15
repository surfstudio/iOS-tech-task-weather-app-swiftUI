// Использовать для того, чтобы объявлять static properties с различными стилями.
// Это нужно, для того, чтобы при применении стиля можно было написать что-то вроде `view.apply(style: .yourStyle)`

import SurfUtils

// swiftlint:disable all
extension UIStyle {

    // MARK: - Montserrat

    static var defaultLabel: UIStyle<UILabel> {
        return LabelStyle(font: UIFont.systemFont(ofSize: 17.0),
                          textColor: Asset.Color.black.color,
                          lineHeight: 17.0,
                          kern: .zero,
                          alignment: .center)
    }
}
// swiftlint:enable all
