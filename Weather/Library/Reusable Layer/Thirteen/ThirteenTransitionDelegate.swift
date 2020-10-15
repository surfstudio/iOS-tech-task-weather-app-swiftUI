import UIKit

final class ThirteenTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {

    // MARK: - Private Properties

    private let driver = ThirteenInteractiveTransitionDriver()

    // MARK: - UIViewControllerTransitioningDelegate

    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        driver.connect(to: presented)
        return ThirteenPresentationViewController(presentedViewController: presented,
                                              presenting: presenting ?? source)
    }

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ThirteenPresentAnimation()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ThirteenDismissAnimation()
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return driver
    }
}
