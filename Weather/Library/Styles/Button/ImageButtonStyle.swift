import SurfUtils

final class ImageButtonStyle: UIStyle<UIButton> {

    // MARK: - Private Properties

    private let imagesAndStates: [(UIImage, UIButton.State)]
    private let backgroundColor: UIColor
    private let cornerRadius: CGFloat
    private let shadowColor: UIColor
    private let shadowOffset: CGSize
    private let tintColor: UIColor?

    // MARK: - Lifecycle

    init(imagesAndStates: [(UIImage, UIButton.State)],
         backgroundColor: UIColor,
         cornerRadius: CGFloat,
         shadowColor: UIColor,
         shadowOffset: CGSize,
         tintColor: UIColor? = nil) {
        self.imagesAndStates = imagesAndStates
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffset
        self.tintColor = tintColor
    }

    // MARK: - UIStyle

    override func apply(for view: UIButton) {
        view.setTitle(nil, for: .normal)
        imagesAndStates.forEach { view.setImage($0.0, for: $0.1) }
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = false
        view.layer.shadowColor = shadowColor.cgColor
        view.layer.shadowRadius = cornerRadius
        view.layer.shadowOffset = shadowOffset
        view.layer.shadowOpacity = 1.0
        if let tintColor = tintColor {
            view.tintColor = tintColor
        }
    }
}
