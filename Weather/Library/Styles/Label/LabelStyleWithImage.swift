import UIKit
import SurfUtils

final class LabelStyleWithImage: LabelStyle {

    let image: UIImage

    init(font: UIFont,
         textColor: UIColor,
         lineHeight: CGFloat,
         kern: CGFloat,
         alignment: NSTextAlignment,
         numberOfLines: Int = 0,
         lineBreakMode: NSLineBreakMode = .byWordWrapping,
         image: UIImage) {

        self.image = image
        super.init(font: font,
                   textColor: textColor,
                   lineHeight: lineHeight,
                   kern: kern,
                   alignment: alignment,
                   numberOfLines: numberOfLines,
                   lineBreakMode: lineBreakMode,
                   useAttributedText: false)
    }

    override func apply(for view: UILabel) {
        let attrs: [StringAttribute] = [
            .lineHeight(lineHeight, font: font),
            .kern(kern),
            .foregroundColor(textColor),
            .aligment(alignment),
            .lineBreakMode(lineBreakMode)
        ]

        let attachment = NSTextAttachment()
        attachment.image = self.image
        attachment.bounds = .init(x: 0, y: -5, width: 36, height: 24)
        let attachmentString = NSMutableAttributedString(attachment: attachment)

        view.numberOfLines = numberOfLines

        var text = view.text ?? ""

        text = " " + text

        let attrStr = text.with(attributes: attrs)

        attachmentString.append(attrStr)

        view.attributedText = attachmentString
    }
}
