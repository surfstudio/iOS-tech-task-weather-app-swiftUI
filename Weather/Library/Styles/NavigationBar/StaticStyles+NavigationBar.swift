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
}
