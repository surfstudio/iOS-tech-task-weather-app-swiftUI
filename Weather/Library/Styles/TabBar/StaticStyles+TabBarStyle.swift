import SurfUtils

extension UIStyle {
    static var defaultTabBar: UIStyle<UITabBar> {
        return TabBarStyle(font: UIFont.systemFont(ofSize: 10.0),
                           normalColor: Asset.Color.black.color,
                           selectedColor: Asset.Color.white.color)
    }
}
