enum ViewState {
    case error(ViewStateInfo)
    case empty(ViewStateInfo)
    case loading
    case normal
}

struct ViewStateInfo {
    let message: String
    let action: String

    init(_ message: String, action: String = Localized.Common.Button.repeat) {
        self.message = message
        self.action = action
    }
}
