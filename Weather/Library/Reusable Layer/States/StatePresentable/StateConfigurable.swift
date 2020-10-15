import UIKit

protocol StateConfigurable {
    func set(state: ViewState)
}

extension StateConfigurable where Self: MultiStatesPresentable {

    func set(state: ViewState) {
        switch state {
        case .empty(let model):
            hideErrorView()
            hideLoaderView()
            showEmptyView(message: model.message, action: model.action, nil)
        case .error(let model):
            hideEmptyView()
            hideLoaderView()
            showErrorView(message: model.message, action: model.action, nil)
        case .loading:
            hideEmptyView()
            hideErrorView()
            showLoaderView()
        case .normal:
            hideEmptyView()
            hideErrorView()
            hideLoaderView()
        }
    }

}
