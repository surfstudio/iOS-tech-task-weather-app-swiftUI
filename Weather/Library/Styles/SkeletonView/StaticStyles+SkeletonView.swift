import SurfUtils

extension UIStyle {
    static var defaultWhite: UIStyle<SkeletonView> {
        return SkeletonViewStyle(subviewsCornerRadius: 0,
                                 backgroundColor: .clear,
                                 gradientBackgroundColor: Asset.Color.white.color.withAlphaComponent(0),
                                 gradientMovingColor: Asset.Color.white.color.withAlphaComponent(0.8))
    }
}
