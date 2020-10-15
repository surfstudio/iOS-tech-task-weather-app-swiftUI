import SurfUtils

class LabelStyle: UIStyle<UILabel> {

    // MARK: - Private Properties

    let font: UIFont
    let textColor: UIColor
    let lineHeight: CGFloat
    let kern: CGFloat
    let alignment: NSTextAlignment
    let numberOfLines: Int
    let lineBreakMode: NSLineBreakMode
    let useAttributedText: Bool

    // MARK: - Lifecycle

    init(font: UIFont,
         textColor: UIColor,
         lineHeight: CGFloat,
         kern: CGFloat,
         alignment: NSTextAlignment,
         numberOfLines: Int = 0,
         lineBreakMode: NSLineBreakMode = .byWordWrapping,
         useAttributedText: Bool = false) {
        self.font = font
        self.textColor = textColor
        self.lineHeight = lineHeight
        self.kern = kern
        self.alignment = alignment
        self.numberOfLines = numberOfLines
        self.lineBreakMode = lineBreakMode
        self.useAttributedText = useAttributedText
    }

    // MARK: - UIStyle

    override func apply(for view: UILabel) {
        let attrs: [StringAttribute] = [
            .lineHeight(lineHeight, font: font),
            .kern(kern),
            .foregroundColor(textColor),
            .aligment(alignment),
            .lineBreakMode(lineBreakMode)
        ]
        view.numberOfLines = numberOfLines

        if self.useAttributedText, let text = view.attributedText {
            let str = NSMutableAttributedString(attributedString: text)
            str.addAttributes(attrs.toDictionary(), range: NSRange(location: 0, length: text.length))
            view.attributedText = str
            return
        }

        view.attributedText = view.text?.with(attributes: attrs)
    }
}
