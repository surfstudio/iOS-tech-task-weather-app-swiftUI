import SurfUtils

// swiftlint:disable all
extension UIStyle {
    static var whiteNavigationBar: UIStyle<UINavigationBar> {
        return NavigationBarStyle(barTintColor: Asset.Color.white.color,
                                  isTranslucent: false)
    }

    static var clearNavigationBar: UIStyle<UINavigationBar> {
        return NavigationBarStyle(barTintColor: .clear,
                                  isTranslucent: true)
    }

    static var whiteTitleNavigationBar: UIStyle<UINavigationBar> {
        return NavigationBarStyle(barTintColor: .clear,
                                  tintColor: Asset.Color.white.color,
                                  isTranslucent: true,
                                  barStyle: .black,
                                  titleAttributes: [.foregroundColor(Asset.Color.white.color),
                                                    .font(FontFamily.SFProDisplay.bold.font(size: 18.0))])
    }

    static var blackTitleNavigationBar: UIStyle<UINavigationBar> {
        return NavigationBarStyle(barTintColor: .clear,
                                  tintColor: Asset.Color.black.color,
                                  isTranslucent: true,
                                  titleAttributes: [.foregroundColor(Asset.Color.black.color),
                                                    .font(FontFamily.SFProDisplay.bold.font(size: 18.0))])
    }
}
// swiftlint:enable all
