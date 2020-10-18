// Использовать для того, чтобы объявлять static properties с различными стилями.
// Это нужно, для того, чтобы при применении стиля можно было написать что-то вроде `view.apply(style: .yourStyle)`

import SurfUtils

// swiftlint:disable all
extension UIStyle {

    // MARK: - SFProText

    static var defaultLabel: UIStyle<UILabel> {
        return LabelStyle(font: UIFont.systemFont(ofSize: 17.0),
                          textColor: Asset.Color.black.color,
                          lineHeight: 17.0,
                          kern: .zero,
                          alignment: .center)
    }

    static var TS16BlackLeft: UIStyle<UILabel> {
        return LabelStyle(font: FontFamily.SFProText.semibold.font(size: 16.0),
                          textColor: Asset.Color.black.color,
                          lineHeight: 16.0,
                          kern: .zero,
                          alignment: .left)
    }

    static var TR15GreyLeft: UIStyle<UILabel> {
        return LabelStyle(font: FontFamily.SFProText.regular.font(size: 15.0),
                          textColor: Asset.Color.grey.color,
                          lineHeight: 15.0,
                          kern: .zero,
                          alignment: .left)
    }

    static var TR16BlackCenter: UIStyle<UILabel> {
        return LabelStyle(font: FontFamily.SFProText.regular.font(size: 15.0),
                          textColor: Asset.Color.black.color,
                          lineHeight: 15.0,
                          kern: .zero,
                          alignment: .center)
    }
}
// swiftlint:enable all
