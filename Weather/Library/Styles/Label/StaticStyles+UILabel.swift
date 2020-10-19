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

    static var TM18WhiteCenter: UIStyle<UILabel> {
        return LabelStyle(font: FontFamily.SFProText.medium.font(size: 18.0),
                          textColor: Asset.Color.white.color,
                          lineHeight: 18.0,
                          kern: .zero,
                          alignment: .center)
    }

    static var TR14WhiteCenter: UIStyle<UILabel> {
        return LabelStyle(font: FontFamily.SFProText.regular.font(size: 14.0),
                          textColor: Asset.Color.white.color,
                          lineHeight: 14.0,
                          kern: .zero,
                          alignment: .center)
    }

    static var TB18WhiteCenter: UIStyle<UILabel> {
        return LabelStyle(font: FontFamily.SFProText.bold.font(size: 18.0),
                          textColor: Asset.Color.white.color,
                          lineHeight: 18.0,
                          kern: .zero,
                          alignment: .center)
    }

    static var TB18White40Center: UIStyle<UILabel> {
        return LabelStyle(font: FontFamily.SFProText.bold.font(size: 18.0),
                          textColor: Asset.Color.white40.color,
                          lineHeight: 18.0,
                          kern: .zero,
                          alignment: .center)
    }

    static var TB18WhiteRight: UIStyle<UILabel> {
        return LabelStyle(font: FontFamily.SFProText.bold.font(size: 18.0),
                          textColor: Asset.Color.white.color,
                          lineHeight: 18.0,
                          kern: .zero,
                          alignment: .right)
    }

    static var TB18White40Right: UIStyle<UILabel> {
        return LabelStyle(font: FontFamily.SFProText.bold.font(size: 18.0),
                          textColor: Asset.Color.white40.color,
                          lineHeight: 18.0,
                          kern: .zero,
                          alignment: .right)
    }

    static var TB13WhiteCenter: UIStyle<UILabel> {
        return LabelStyle(font: FontFamily.SFProText.bold.font(size: 13.0),
                          textColor: Asset.Color.white.color,
                          lineHeight: 13.0,
                          kern: .zero,
                          alignment: .center)
    }

    static var TR13WhiteCenter: UIStyle<UILabel> {
        return LabelStyle(font: FontFamily.SFProText.regular.font(size: 13.0),
                          textColor: Asset.Color.white.color,
                          lineHeight: 13.0,
                          kern: .zero,
                          alignment: .center)
    }

    static var TM16WhiteLeft: UIStyle<UILabel> {
        return LabelStyle(font: FontFamily.SFProText.medium.font(size: 16.0),
                          textColor: Asset.Color.white.color,
                          lineHeight: 16.0,
                          kern: .zero,
                          alignment: .left)
    }

    // MARK: - SFProDisplay

    static var DB100WhiteCenter: UIStyle<UILabel> {
        return LabelStyle(font: FontFamily.SFProDisplay.bold.font(size: 100.0),
                          textColor: Asset.Color.white.color,
                          lineHeight: 100.0,
                          kern: .zero,
                          alignment: .center)
    }
}
// swiftlint:enable all
