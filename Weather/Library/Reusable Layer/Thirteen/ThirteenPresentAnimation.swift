import UIKit

final class ThirteenPresentAnimation: NSObject, UIViewControllerAnimatedTransitioning {

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

private extension ThirteenPresentAnimation {
    func getAnimator(context: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        let view = context.view(forKey: .to)
        let viewController = context.viewController(forKey: .to) ?? UIViewController()
        let finalFrame = context.finalFrame(for: viewController)
        view?.frame = finalFrame.offsetBy(dx: .zero, dy: finalFrame.height)
        let animator = UIViewPropertyAnimator(duration: Constants.duration, curve: .easeOut) {
            view?.frame = finalFrame
        }

        animator.addCompletion { _ in
            context.completeTransition(!context.transitionWasCancelled)
        }

        return animator
    }
}
