import SurfUtils

final class SkeletonViewStyle: UIStyle<SkeletonView> {

    // MARK: - Properties

    let subviewsCornerRadius: CGFloat
    let backgroundColor: UIColor
    let gradientBackgroundColor: UIColor
    let gradientMovingColor: UIColor
    let shimmerRatio: Double
    let movingAnimationDuration: CFTimeInterval

    // MARK: - Initalization

    init(subviewsCornerRadius: CGFloat,
         backgroundColor: UIColor,
         gradientBackgroundColor: UIColor,
         gradientMovingColor: UIColor,
         shimmerRatio: Double = 0.5,
         movingAnimationDuration: CFTimeInterval = 1) {
        self.subviewsCornerRadius = subviewsCornerRadius
        self.backgroundColor = backgroundColor
        self.gradientBackgroundColor = gradientBackgroundColor
        self.gradientMovingColor = gradientMovingColor
        self.shimmerRatio = shimmerRatio
        self.movingAnimationDuration = movingAnimationDuration
    }

    // MARK: - UIStyle

    override func apply(for view: SkeletonView) {
        view.subviews.forEach {
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = subviewsCornerRadius
        }
        view.backgroundColor = backgroundColor
        view.gradientBackgroundColor = gradientBackgroundColor
        view.gradientMovingColor = gradientMovingColor
        view.shimmerRatio = shimmerRatio
        view.movingAnimationDuration = movingAnimationDuration
    }

}
