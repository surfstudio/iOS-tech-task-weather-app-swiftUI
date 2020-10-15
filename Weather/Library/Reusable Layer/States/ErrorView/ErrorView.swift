import UIKit

final class ErrorView: UIView {

    // MARK: - IBOutlets

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var actionButton: UIButton!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var contentView: UIView!

    // MARK: - Constraints

    @IBOutlet private weak var messageTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var iconWidthConstraint: NSLayoutConstraint!

    // MARK: - IBActions

    @IBAction private func didActionTapped(_ sender: Any) {
        onAction?(state)
    }

    // MARK: - Properties

    private(set) var state: ErrorViewState = .error
    var onAction: Closure<ErrorViewState>?

    // MARK: - UIView

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureAppearance()
    }

    // MARK: - Public methods

    func configure(message: String, actionTitle: String, config: ErrorViewState) {
        self.state = config
        messageLabel.text = message
        actionButton.setTitle(actionTitle, for: .normal)

        messageTopConstraint.constant = config.messageTopOffset
        iconWidthConstraint.constant = config.iconWidth
        messageLabel.apply(style: config.messageStyle)
        actionButton.apply(style: config.actionStyle)
        iconImageView.image = config.icon
    }

}

// MARK: - Private Configuration

private extension ErrorView {

    func configureAppearance() {
        xibSetup()
        containerView.backgroundColor = .clear
    }

}
