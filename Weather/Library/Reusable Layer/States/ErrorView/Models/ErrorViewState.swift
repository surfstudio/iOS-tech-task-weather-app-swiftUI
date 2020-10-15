import SurfUtils

enum ErrorViewState {
    case error
    case empty
}

extension ErrorViewState: ErrorViewConfigurable {

    var actionStyle: UIStyle<UIButton> {
        return .defaultButton
    }

    var messageStyle: UIStyle<UILabel> {
        return .defaultLabel
    }

    var iconWidth: CGFloat {
        switch self {
        case .error:
            return 72
        case .empty:
            return 152
        }
    }

    var messageTopOffset: CGFloat {
        switch self {
        case .error:
            return 16
        case .empty:
            return 27
        }
    }

    var icon: UIImage {
        switch self {
        case .error:
            return Asset.Image.ErrorView.errorState.image
        case .empty:
            return Asset.Image.ErrorView.emptyState.image
        }
    }

}
