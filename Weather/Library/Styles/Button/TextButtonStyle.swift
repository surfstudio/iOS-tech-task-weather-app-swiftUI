import SurfUtils

final class TextButtonStyle: UIStyle<UIButton> {

    // MARK: - Private Properties

    private let font: UIFont
    private let titleColor: UIColor
    private let backgroundColor: UIColor?
    private let cornerRadius: CGFloat
    private let shadowColor: UIColor
    private let shadowOffset: CGSize
    private let borderColor: UIColor
    private let borderWidth: CGFloat
    private let contentInsets: UIEdgeInsets?
    private let contentHorizontalAlignment: UIControl.ContentHorizontalAlignment?
    private let highlightedColor: UIColor?

    // MARK: - Lifecycle

    init(font: UIFont,
         titleColor: UIColor,
         backgroundColor: UIColor,
         cornerRadius: CGFloat,
         shadowColor: UIColor,
         shadowOffset: CGSize,
         borderColor: UIColor = .clear,
         borderWidth: CGFloat = .zero,
         contentInsets: UIEdgeInsets? = nil,
         contentHorizontalAlignment: UIControl.ContentHorizontalAlignment? = nil,
         highlightedColor: UIColor? = nil) {
        self.font = font
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffset
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.contentInsets = contentInsets
        self.contentHorizontalAlignment = contentHorizontalAlignment
        self.highlightedColor = highlightedColor
    }

    // MARK: - UIStyle

    override func apply(for view: UIButton) {
        view.titleLabel?.font = font
        view.setTitleColor(titleColor, for: .normal)
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = false
        view.layer.shadowColor = shadowColor.cgColor
        view.layer.shadowRadius = cornerRadius
        view.layer.shadowOffset = shadowOffset
        view.layer.shadowOpacity = 1.0
        view.layer.borderColor = borderColor.cgColor
        view.layer.borderWidth = borderWidth
        if let insets = contentInsets {
            view.contentEdgeInsets = insets
        }
        if let alignment = contentHorizontalAlignment {
            view.contentHorizontalAlignment = alignment
        }

        if let color = highlightedColor {
            view.setBackgroundImage(UIImage.coloredImage(frame: CGRect(origin: .zero,
                                                                       size: CGSize(width: 1.0,
                                                                                    height: 1.0)),
                                                         color: color),
                                    for: .highlighted)
        }
    }
}
