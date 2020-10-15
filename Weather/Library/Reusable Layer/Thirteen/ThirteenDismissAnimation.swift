import UIKit

final class ThirteenDismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {

    // MARK: - Constants

    private enum Constants {
        static let duration: TimeInterval = 0.3
    }

    // MARK: - Lifecycle

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Constants.duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = getAnimator(context: transitionContext)
        animator.startAnimation()
    }

    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        return getAnimator(context: transitionContext)
    }
}

// MARK: - Private Methods

private extension ThirteenDismissAnimation {
    func getAnimator(context: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        let view = context.view(forKey: .from)
        let viewController = context.viewController(forKey: .from) ?? UIViewController()
        let initialFrame = context.finalFrame(for: viewController)
        let animator = UIViewPropertyAnimator(duration: Constants.duration, curve: .easeOut) {
            view?.frame = initialFrame.offsetBy(dx: .zero, dy: initialFrame.height)
        }

        animator.addCompletion { _ in
            context.completeTransition(!context.transitionWasCancelled)
        }

        return animator
    }
}
