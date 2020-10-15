import SurfUtils

final class NavigationBarStyle: UIStyle<UINavigationBar> {

    // MARK: - Private Properties

    private let barTintColor: UIColor
    private let isTranslucent: Bool
    private let titleAttributes: [StringAttribute]
    private let largeTitleAttributes: [StringAttribute]

    // MARK: - Lifecycle

    init(barTintColor: UIColor,
         isTranslucent: Bool,
         titleAttributes: [StringAttribute] = [],
         largeTitleAttributes: [StringAttribute] = []) {
        self.barTintColor = barTintColor
        self.isTranslucent = isTranslucent
        self.titleAttributes = titleAttributes
        self.largeTitleAttributes = largeTitleAttributes
    }

    // MARK: - UIStyle

    override func apply(for navigationBar: UINavigationBar) {
        navigationBar.barTintColor = barTintColor
        navigationBar.tintColor = Asset.Color.black.color
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.barStyle = .default
        navigationBar.isTranslucent = isTranslucent
        let backImage = Asset.Image.NavigationItem.back.image
        navigationBar.backIndicatorImage = backImage
        navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationBar.titleTextAttributes = titleAttributes.toDictionary()
        navigationBar.largeTitleTextAttributes = largeTitleAttributes.toDictionary()
        navigationBar.prefersLargeTitles = !largeTitleAttributes.isEmpty

        if UIScreen.main.traitCollection.horizontalSizeClass == .regular {
            navigationBar.layoutMargins.left = 40.0
        }
    }

}