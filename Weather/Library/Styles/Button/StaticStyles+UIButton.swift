// Использовать для того, чтобы объявлять static properties с различными стилями.
// Это нужно, для того, чтобы при применении стиля можно было написать что-то вроде `view.apply(style: .yourStyle)`

import SurfUtils

extension UIStyle {

    // MARK: - TextButtonStyle

    static var defaultButton: UIStyle<UIButton> {
        return TextButtonStyle(font: UIFont.systemFont(ofSize: 16.0),
                               titleColor: Asset.Color.white.color,
                               backgroundColor: Asset.Color.black.color,
                               cornerRadius: 16.0,
                               shadowColor: Asset.Color.black.color,
                               shadowOffset: CGSize(width: .zero, height: 8.0))
    }
}
