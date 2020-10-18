import UIKit

final class ModalNavigationController: UINavigationController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.apply(style: .clearNavigationBar)
        self.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /// При установке `presentationController?.delegate` экран показывается модалкой
        /// Даже если `modalPresentationStyle == .fullScreen`
        if #available(iOS 13.0, *), modalPresentationStyle != .fullScreen {
            presentationController?.delegate = self
        }
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate

extension ModalNavigationController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        (topViewController as? DismissableView)?.didDismiss()
    }
}

// MARK: - UINavigationControllerDelegate

extension ModalNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        navigationController.topViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

// MARK: - Actions

private extension ModalNavigationController {

    @objc
    func close() {
        dismiss(animated: true) { [weak self] in
            (self?.topViewController as? DismissableView)?.didDismiss()
        }
    }

}
