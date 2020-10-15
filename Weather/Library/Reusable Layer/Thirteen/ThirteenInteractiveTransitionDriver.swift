import UIKit

final class ThirteenInteractiveTransitionDriver: UIPercentDrivenInteractiveTransition {

    // MARK: - Private Properties

    private var panGestureRecognizer: UIPanGestureRecognizer?
    private weak var presentedController: UIViewController?

    private var isDismissCanceled: Bool = false

    // MARK: - UIPercentDrivenInteractiveTransition

    override var wantsInteractiveStart: Bool {
        get {
            return panGestureRecognizer?.state == .began
        }
        set {
            super.wantsInteractiveStart = newValue
        }
    }

    // MARK: - Public Methods

    func connect(to viewController: UIViewController) {
        presentedController = viewController
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        presentedController?.view.addGestureRecognizer(recognizer)
        panGestureRecognizer = recognizer
    }
}

// MARK: - Private Methods

private extension ThirteenInteractiveTransitionDriver {
    @objc
    private func handlePan(recognizer: UIPanGestureRecognizer) {
        let maxTranslation = presentedController?.view.frame.height ?? 0.0

        switch recognizer.state {
        case .began:
            pause()

            guard percentComplete.isZero else { return }
            isDismissCanceled = false
            presentedController?.dismiss(animated: true) { [weak self] in
                guard self?.isDismissCanceled == false else { return }
                let vc: DismissableView?
                if let navController = (self?.presentedController as? UINavigationController) {
                    vc = navController.topViewController as? DismissableView
                } else {
                    vc = self?.presentedController as? DismissableView
                }
                vc?.didDismiss()
            }
        case .changed:
            configureForChanged(recognizer: recognizer, maxTranslation: maxTranslation)
        case .ended, .cancelled:
            configureForEndedAndCancelled(recognizer: recognizer,
                                          maxTranslation: maxTranslation)
        case .failed:
            isDismissCanceled = true
            cancel()
        default:
            break
        }
    }

    func configureForChanged(recognizer: UIPanGestureRecognizer, maxTranslation: CGFloat) {
        let translation = recognizer.translation(in: recognizer.view).y
        recognizer.setTranslation(.zero, in: nil)

        let percentIncrement = translation / maxTranslation
        update(percentComplete + percentIncrement)
    }

    func configureForEndedAndCancelled(recognizer: UIPanGestureRecognizer, maxTranslation: CGFloat) {
        let multiplier = 1.0 / (1.0 - UIScrollView.DecelerationRate.normal.rawValue) / 1000.0

        let velocity = recognizer.velocity(in: recognizer.view)
        let expectedLocation = CGPoint(x: velocity.x * multiplier,
                                       y: velocity.y * multiplier)
        let x = recognizer.location(in: recognizer.view).x + expectedLocation.x
        let y = recognizer.location(in: recognizer.view).y + expectedLocation.y
        let endLocation = CGPoint(x: x, y: y)
        let isHalfDown = endLocation.y > maxTranslation / 2.0

        if isHalfDown {
            finish()
        } else {
            isDismissCanceled = true
            cancel()
        }
    }
}
