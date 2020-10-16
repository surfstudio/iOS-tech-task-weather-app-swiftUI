// Использовать для того, чтобы объявлять static properties с различными стилями.
// Это нужно, для того, чтобы при применении стиля можно было написать что-то вроде `view.apply(style: .yourStyle)`

import SurfUtils

// swiftlint:disable all
extension UIStyle {

    // MARK: - Montserrat

    static var defaultSearchBar: UIStyle<UISearchBar> {
        return SearchBarStyle()
    }
}
// swiftlint:enable all
