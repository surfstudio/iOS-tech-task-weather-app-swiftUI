import UIKit

final class ThirteenPresentationViewController: UIPresentationController {

    // MARK: - Private Properties

    private let backgroundView = UIView()
    private var height: CGFloat = .zero

    // MARK: - Lifecycle

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        let y = max(28.0, containerView.safeAreaInsets.top)
        return CGRect(x: 0.0,
                      y: y,
                      width: containerView.bounds.width,
                      height: containerView.bounds.height - y)
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        backgroundView.frame = containerView?.frame ?? .zero
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        backgroundView.backgroundColor = Asset.Color.black40.color
        backgroundView.alpha = .zero
        containerView?.addSubview(backgroundView)
        animateBackgroundViewAlpha(to: 1.0)

        guard let presentedView = presentedView else { return }

        presentedView.layer.cornerRadius = 24.0
        presentedView.layer.masksToBounds = true
        presentedView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        containerView?.addSubview(presentedView)
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        guard !completed else { return }
        backgroundView.removeFromSuperview()
    }

    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        animateBackgroundViewAlpha(to: .zero)
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        guard completed else { return }
        backgroundView.removeFromSuperview()
    }
}

// MARK: - Private Methods

private extension ThirteenPresentationViewController {
    private func animateBackgroundViewAlpha(to value: CGFloat) {
        guard
            let coordinator = presentedViewController.transitionCoordinator
        else {
            backgroundView.alpha = value
            return
        }

        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.backgroundView.alpha = value
        })
    }
}
