import SurfUtils

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
                                  titleAttributes: [.foregroundColor(Asset.Color.white.color),
                                                    .font(FontFamily.SFProDisplay.bold.font(size: 18.0))])
    }
}
