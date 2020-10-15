import NodeKit

extension Error {
    var isNetwork: Bool {
        guard let error = self as? BaseTechnicalError else { return false }
        return error == .noInternetConnection
    }
}
