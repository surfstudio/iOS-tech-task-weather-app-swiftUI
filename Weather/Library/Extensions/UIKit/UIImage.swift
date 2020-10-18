import UIKit

extension UIImage {
    static func coloredImage(frame: CGRect, color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContext(frame.size)
        color.setFill()
        UIGraphicsGetCurrentContext()?.fill(frame)
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resultImage
    }

    static func coloredImage(frame: CGRect, color: UIColor, radius: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(frame.size, false, .zero)
        let context = UIGraphicsGetCurrentContext()
        color.setFill()
        let path = UIBezierPath(roundedRect: frame, cornerRadius: CGFloat(radius)).cgPath
        context?.addPath(path)
        context?.fillPath()
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }

    static func roundedImage(image: UIImage, cornerRadius: CGFloat) -> UIImage? {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: image.size)
        UIGraphicsBeginImageContextWithOptions(image.size, false, 1)
        UIBezierPath(roundedRect: rect, cornerRadius: CGFloat(cornerRadius)).addClip()
        image.draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
