import SwiftMessages

protocol SnackDisplayable: ErrorDisplayable {
    func showSnack(with text: String)
}

extension SnackDisplayable {
    func showSnack(with text: String) {
        let view = MessageView.viewFromNib(layout: .statusLine)
        view.bodyLabel?.text = text
        var config = SwiftMessages.Config()
        config.presentationContext = .window(windowLevel: .normal)
        SwiftMessages.show(config: config, view: view)
    }
}

extension SnackDisplayable {
    func show(error: Error) {
        guard !error.isNetwork else {
            self.showNetworkError()
            return
        }
        showSnack(with: error.localizedDescription)
    }

    func showNetworkError() {
        showSnack(with: Localized.Error.noInternetConnection)
    }
}
