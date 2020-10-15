import SurfUtils

final class TabBarStyle: UIStyle<UITabBar> {

    // MARK: - Private Properties

    private let font: UIFont
    private let normalColor: UIColor
    private let selectedColor: UIColor

    // MARK: - Lifecycle

    init(font: UIFont,
         normalColor: UIColor,
         selectedColor: UIColor) {
        self.font = font
        self.normalColor = normalColor
        self.selectedColor = selectedColor
    }

    // MARK: - UIStyle

    override func apply(for tabBar: UITabBar) {
        let normalStateAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: normalColor
        ]
        let selectedStateAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: selectedColor
        ]

        if #available(iOS 13, *) {
            let appearance = UITabBarAppearance()
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalStateAttributes
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedStateAttributes
            appearance.backgroundImage = UIImage()
            appearance.backgroundColor = .clear
            appearance.backgroundEffect = .none
            appearance.shadowImage = nil
            appearance.shadowColor = nil
            appearance.stackedLayoutAppearance.normal.iconColor = normalColor
            appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
            tabBar.standardAppearance = appearance
        } else {
            UITabBarItem.appearance().setTitleTextAttributes(normalStateAttributes, for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes(selectedStateAttributes, for: .selected)
            tabBar.backgroundImage = UIImage()
            tabBar.shadowImage = UIImage()
            tabBar.tintColor = selectedColor
            tabBar.unselectedItemTintColor = normalColor
        }
    }

}
