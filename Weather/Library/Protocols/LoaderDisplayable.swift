import UIKit

protocol LoaderDisplayable {
    func startLoader()
    func stopLoader()
}

extension LoaderDisplayable where Self: UIViewController {
    func startLoader() {
        let backgroundView = UIView()
        backgroundView.tag = 666
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = Asset.Color.grey.color.withAlphaComponent(0.5)
        view.addSubview(backgroundView)

        let indicatorView = UIActivityIndicatorView(style: .whiteLarge)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.startAnimating()
        backgroundView.addSubview(indicatorView)

        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            indicatorView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
        ])
    }

    func stopLoader() {
        view.subviews.first(where: { $0.tag == 666 })?.removeFromSuperview()
    }
}
