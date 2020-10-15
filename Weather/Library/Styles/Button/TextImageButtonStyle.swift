import SurfUtils

class TextImageButtonStyle: UIStyle<UIButton> {

    // MARK: - Private Properties

    let font: UIFont
    private let titleColor: UIColor
    private let image: UIImage
    let backgroundColor: UIColor
    let cornerRadius: CGFloat
    private let shadowColor: UIColor
    private let shadowOffset: CGSize
    private let contentInsets: UIEdgeInsets
    private let titleInsets: UIEdgeInsets
    private let imageInsets: UIEdgeInsets
    private let verticalAlignment: UIControl.ContentVerticalAlignment
    private let highlightedColor: UIColor?

    // MARK: - Lifecycle

    init(font: UIFont,
         titleColor: UIColor,
         image: UIImage,
         backgroundColor: UIColor,
         cornerRadius: CGFloat,
         shadowColor: UIColor,
         shadowOffset: CGSize,
         contentInsets: UIEdgeInsets = .zero,
         titleInsets: UIEdgeInsets,
         imageInsets: UIEdgeInsets,
         verticalAlignment: UIControl.ContentVerticalAlignment = .top,
         highlightedColor: UIColor? = nil) {
        self.font = font
        self.titleColor = titleColor
        self.image = image
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffset
        self.contentInsets = contentInsets
        self.titleInsets = titleInsets
        self.imageInsets = imageInsets
        self.verticalAlignment = verticalAlignment
        self.highlightedColor = highlightedColor
    }

    // MARK: - UIStyle

    override func apply(for view: UIButton) {
        view.titleLabel?.font = font
        view.setTitleColor(titleColor, for: .normal)
        view.setImage(image, for: .normal)
        view.setBackgroundImage(UIImage.coloredImage(frame: view.bounds, color: backgroundColor, radius: cornerRadius), for: .normal)
        view.layer.shadowColor = shadowColor.cgColor
        view.layer.shadowRadius = cornerRadius
        view.layer.shadowOffset = shadowOffset
        view.layer.shadowOpacity = 1.0
        view.contentVerticalAlignment = verticalAlignment
        view.contentHorizontalAlignment = .leading
        view.contentEdgeInsets = contentInsets
        view.titleEdgeInsets = titleInsets
        view.imageEdgeInsets = imageInsets

        if let color = highlightedColor {
            view.setBackgroundImage(UIImage.coloredImage(frame: CGRect(origin: .zero,
                                                                       size: CGSize(width: 1.0,
                                                                                    height: 1.0)),
                                                         color: color),
                                    for: .highlighted)
        }
    }
}
