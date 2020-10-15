import UIKit

protocol MultiStatesPresentable {
    var useTopSafeArea: Bool { get }
    var containerView: UIView { get }
    var sharedTopOffset: CGFloat? { get }

    /// Если указан параметр callback, то на действие вызовется только callback
    /// Если он будет nil, то вызовется соответсвующий метод performErrorStateAction/performEmptyStateAction
    func showErrorView(message: String, action: String, _ callback: EmptyClosure?)
    func showEmptyView(message: String, action: String, _ callback: EmptyClosure?)
    func showLoaderView()

    func hideErrorView()
    func hideEmptyView()
    func hideLoaderView()

    /// Вызываются дефолтно на действия кроме случая когда указан callback в вызывающих методах
    func performErrorStateAction()
    func performEmptyStateAction()
}

extension MultiStatesPresentable where Self: UIViewController {

    var containerView: UIView {
        return view
    }

    var useTopSafeArea: Bool {
        return true
    }

    var sharedTopOffset: CGFloat? {
        return nil
    }

    private var loaderView: LoadingView? {
        return containerView.subviews.first { $0 is LoadingView } as? LoadingView
    }

    private var errorView: ErrorView? {
        let errorView = containerView.subviews.first { ($0 as? ErrorView)?.state == .error }
        return errorView as? ErrorView
    }

    private var emptyView: ErrorView? {
        let emptyView = containerView.subviews.first { ($0 as? ErrorView)?.state == .empty }
        return emptyView as? ErrorView
    }

    func showEmptyView(message: String, action: String, _ callback: EmptyClosure?) {
        guard emptyView == nil else {
            emptyView?.configure(message: message, actionTitle: action, config: .empty)
            return
        }
        createView(with: .empty, message: message, action: action, callback: callback)
    }

    func showErrorView(message: String, action: String, _ callback: EmptyClosure?) {
        guard emptyView == nil else {
            emptyView?.configure(message: message, actionTitle: action, config: .error)
            return
        }
        createView(with: .error, message: message, action: action, callback: callback)
    }

    func showLoaderView() {
        guard let provider = self as? LoadingDataProvider else {
            return
        }
        guard loaderView == nil else {
            loaderView?.configure(blocks: provider.getBlocks(), config: provider.config)
            loaderView?.setNeedAnimating(true)
            return
        }

        let loadingView = LoadingView(frame: viewFrame)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.backgroundColor = containerView.backgroundColor
        loadingView.configure(blocks: provider.getBlocks(), config: provider.config)
        loadingView.clipsToBounds = true
        containerView.addSubview(loadingView)
        containerView.bringSubviewToFront(loadingView)

        strecth(view: loadingView)

        // Костыль-(фича) когда вызывается из viewDidLoad первый раз шиммер бежит до середины экрана и выглядит как багованный шимер
        // так хотя бы красиво все
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            loadingView.setNeedAnimating(true)
        }

        updateContainerState()
    }

    func hideErrorView() {
        errorView?.removeFromSuperview()
        updateContainerState()
    }

    func hideEmptyView() {
        emptyView?.removeFromSuperview()
        updateContainerState()
    }

    func hideLoaderView() {
        loaderView?.removeFromSuperview()
        updateContainerState()
    }

    // Реализуется в своем контроллере если нужны
    func performErrorStateAction() {}
    func performEmptyStateAction() {}

}

extension MultiStatesPresentable where Self: UIView {

    var useTopSafeArea: Bool {
        return false
    }

    var containerView: UIView {
        return self
    }

    var sharedTopOffset: CGFloat? {
        return nil
    }

    private var loaderView: LoadingView? {
        return containerView.subviews.first { $0 is LoadingView } as? LoadingView
    }

    func showLoaderView() {
        guard let provider = self as? LoadingDataProvider else {
            return
        }
        guard loaderView == nil else {
            loaderView?.configure(blocks: provider.getBlocks(), config: provider.config)
            loaderView?.setNeedAnimating(true)
            return
        }

        addLoadingView(blocks: provider.getBlocks(), config: provider.config)
        updateContainerState()
    }

    func hideLoaderView() {
        loaderView?.removeFromSuperview()
        updateContainerState()
    }

    func showErrorView(message: String, action: String, _ callback: EmptyClosure?) {
        guard let provider = self as? LoadingDataProvider else {
            return
        }

        addLoadingView(needAnimating: false, blocks: provider.getBlocks(), config: provider.config)
        updateContainerState()
    }

    func hideErrorView() {
        loaderView?.removeFromSuperview()
        updateContainerState()
    }

    func showEmptyView(message: String, action: String, _ callback: EmptyClosure?) { }
    func hideEmptyView() { }

    func performErrorStateAction() {}
    func performEmptyStateAction() {}

}

// MARK: - Support

private extension MultiStatesPresentable where Self: UIViewController {

    var viewFrame: CGRect {
        guard let topOffset = sharedTopOffset else {
            return containerView.bounds
        }
        var frame = containerView.bounds
        frame.origin.y += topOffset
        frame.size.height -= topOffset
        return frame
    }

    func updateContainerState() {
        guard containerView != view else {
            return
        }
        containerView.isUserInteractionEnabled = !containerView.subviews.isEmpty
    }

    func createView(with type: ErrorViewState,
                    message: String,
                    action: String,
                    callback: EmptyClosure?) {

        let errorView = ErrorView(frame: viewFrame)
        errorView.configure(message: message, actionTitle: action, config: type)
        errorView.backgroundColor = containerView.backgroundColor
        errorView.onAction = { [weak self] type in
            guard callback == nil else {
                callback?()
                return
            }
            switch type {
            case .empty:
                self?.performEmptyStateAction()
            case .error:
                self?.performErrorStateAction()
            }
        }

        containerView.addSubview(errorView)
        containerView.bringSubviewToFront(errorView)
        strecth(view: errorView)
        updateContainerState()
    }

    func strecth(view: UIView) {
        guard useTopSafeArea else {
            containerView.stretch(view: view)
            return
        }
        let safeArea = containerView.safeAreaLayoutGuide
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: safeArea.topAnchor),
            view.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }

}

private extension MultiStatesPresentable where Self: UIView {

    func updateContainerState() {
        guard containerView != self else {
            return
        }
        containerView.isUserInteractionEnabled = !containerView.subviews.isEmpty
    }

    func addLoadingView(needAnimating: Bool = true, blocks: [LoadingViewBlockAbstract], config: LoadingViewConfig) {
        let loadingView = LoadingView()
        loadingView.configure(blocks: blocks, config: config)
        loadingView.setNeedAnimating(needAnimating)
        loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        containerView.addSubview(loadingView)
        containerView.stretch(view: loadingView)
        containerView.bringSubviewToFront(loadingView)
    }

}
