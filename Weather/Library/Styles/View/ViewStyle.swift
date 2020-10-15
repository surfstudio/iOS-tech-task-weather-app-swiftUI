import SurfUtils

final class ViewStyle: UIStyle<UIView> {

    // MARK: - Private Properties

    private let backgroundColor: UIColor
    private let cornerRadius: CGFloat
    private let masksToBounds: Bool
    private let maskedCorners: CACornerMask
    private let borderColor: UIColor?

    // MARK: - Lifecycle

    init(backgroundColor: UIColor,
         cornerRadius: CGFloat,
         masksToBounds: Bool = false,
         maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner],
         borderColor: UIColor? = nil) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.maskedCorners = maskedCorners
        self.borderColor = borderColor
        self.masksToBounds = masksToBounds
    }

    // MARK: - UIStyle

    override func apply(for view: UIView) {
        view.backgroundColor = backgroundColor
        if masksToBounds {
            view.layer.masksToBounds = masksToBounds
        }
        view.layer.maskedCorners = maskedCorners
        view.layer.cornerRadius = cornerRadius
        if let borderColor = borderColor {
            view.layer.borderColor = borderColor.cgColor
            view.layer.borderWidth = 1.0
        }
    }
}
