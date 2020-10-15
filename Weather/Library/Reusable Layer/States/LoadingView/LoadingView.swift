import UIKit
import SurfUtils

public final class LoadingView: UIView, LoadingViewAbstract {

    // MARK: - Constants

    private enum Constants {
        static let gradientColorFrom = Asset.Color.white.color.withAlphaComponent(0)
        static let gradientColorTo = Asset.Color.white.color.withAlphaComponent(1)
        static let gradientLocations: [NSNumber] = [0.5, 0.95]
    }

    // MARK: - Properties

    private var blocks: [LoadingViewBlockAbstract] = []
    private var config = LoadingViewConfig()
    private var topOffset: CGFloat = 0

    private var skeletonView = SkeletonView()
    private var gradientContainer = UIView()
    private var gradientLayer = CAGradientLayer()

    // MARK: - Initialization

    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureAppearance()
    }

    // MARK: - UIView

    override public func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = gradientContainer.bounds
    }

    // MARK: - Public Methods

    func configure(blocks: [LoadingViewBlockAbstract], config: LoadingViewConfig = .init()) {
        removeOldBlocks()
        self.blocks = blocks
        self.config = config
        self.topOffset = config.topOffset

        repeatLastIfNeeded()
        addBlocksToView()

        bringSubviewToFront(skeletonView)
        bringSubviewToFront(gradientContainer)
        gradientContainer.isHidden = !config.needGradient
        setupConstraints()
    }

    // MARK: - LoaderViewAbstract

    public func setNeedAnimating(_ needAnimating: Bool) {
        skeletonView.shimmering = needAnimating
    }

}

// MARK: - Appearance

private extension LoadingView {

    func configureAppearance() {
        backgroundColor = .white
        configureSkeletonView()
        configureGradient()
    }

    func configureSkeletonView() {
        addSubview(skeletonView)
        self.stretch(view: skeletonView)

        let skeletonSubview = UIView()
        skeletonView.addSubview(skeletonSubview)

        [skeletonView, skeletonSubview].forEach { $0.backgroundColor = .clear }
        skeletonView.stretch(view: skeletonSubview)

        skeletonView.maskingViews = [skeletonSubview]
        skeletonView.gradientBackgroundColor = Asset.Color.white.color.withAlphaComponent(0)
        skeletonView.gradientMovingColor = Asset.Color.white.color.withAlphaComponent(0.5)
        skeletonView.shimmerRatio = 0.5
        skeletonView.movingAnimationDuration = 1
    }

    func configureGradient() {
        addSubview(gradientContainer)
        self.stretch(view: gradientContainer)

        gradientLayer.colors = [
            Constants.gradientColorFrom.cgColor,
            Constants.gradientColorTo.cgColor
        ]
        gradientLayer.locations = Constants.gradientLocations

        gradientContainer.backgroundColor = UIColor.clear
        gradientContainer.layer.addSublayer(gradientLayer)
    }

}

// MARK: - Private Methods

private extension LoadingView {

    func repeatLastIfNeeded() {
        // repeat last subview if there are few subviews
        guard config.needRepeatLast else {
            return
        }
        let subviewsHeight = blocks.flatMap({ $0.getSubviews() }).map({ $0.height }).reduce(0, +)
        let screenHeight = UIScreen.main.bounds.height
        if subviewsHeight < screenHeight {
            let diff = screenHeight - subviewsHeight
            guard
                let lastBlock = blocks.last,
                let lastView = lastBlock.getSubviews().last
            else {
                return
            }
            let lastViewHeight = lastView.height
            let countBlocksToAdd = Int((diff / lastViewHeight).rounded(.down)) + 1
            let repeatCount = lastBlock.repeatCount + countBlocksToAdd
            blocks.removeLast()
            blocks.append(lastBlock.reconfigure(repeatCount: repeatCount))
        }
    }

    func addBlocksToView() {
        blocks.forEach { block in
            block.getSubviews().forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                addSubview($0)
            }
            block.configure(color: config.placeholderColor)
        }
    }

    func setupConstraints() {
        var prev: UIView?
        for view in blocks.flatMap({ $0.getSubviews() }) {
            var constraints = [
                view.topAnchor.constraint(equalTo: prev?.bottomAnchor ?? topAnchor,
                                          constant: prev == nil ? topOffset : 0),
                view.leftAnchor.constraint(equalTo: leftAnchor),
                view.rightAnchor.constraint(equalTo: rightAnchor)
            ]
            if view.height > 0 {
                constraints.append(view.heightAnchor.constraint(equalToConstant: view.height))
            } else {
                constraints.append(view.bottomAnchor.constraint(equalTo: bottomAnchor))
            }
            NSLayoutConstraint.activate(constraints)
            prev = view
            view.layoutIfNeeded()
        }
    }

    func removeOldBlocks() {
        blocks.flatMap({ $0.getSubviews() }).forEach {
            $0.removeFromSuperview()
        }
        blocks.removeAll()
    }

}
