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
}
