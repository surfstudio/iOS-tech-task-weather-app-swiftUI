import SwiftMessages
import NodeKit

protocol SnackDisplayable: ErrorDisplayable {
    func showSnack(with text: String)
}

extension SnackDisplayable {
    func showSnack(with text: String) {
        let view = MessageView.viewFromNib(layout: .statusLine)
        view.bodyLabel?.text = text
        view.bodyLabel?.apply(style: .TR16BlackCenter)
        view.backgroundColor = Asset.Color.lightGrey.color
        view.layer.borderColor = Asset.Color.darkGrey.color.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 16
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

        if case ResponseHttpErrorProcessorNodeError.notFound = error {
            showSnack(with: L10n.Error.notFound)
            return
        }

        showSnack(with: L10n.Error.notDefined)
    }

    func showNetworkError() {
        showSnack(with: Localized.Error.noInternetConnection)
    }
}
