//
//  ProgressBar.swift
//  Weather
//

import UIKit

final class ProgressBar: UIView {

    // MARK: - Private Properties

    private let progress: Double

    // MARK: - Lifecycle

    init(progress: Double) {
        self.progress = progress
        super.init(frame: .zero)
        self.backgroundColor = .clear
    }

    override init(frame: CGRect) {
        self.progress = .zero
        super.init(frame: frame)
        self.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        self.progress = .zero
        super.init(coder: coder)
        self.backgroundColor = .clear
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let backgroundPath = UIBezierPath(roundedRect: rect, cornerRadius: 4.0)
        Asset.Color.white40.color.setFill()
        backgroundPath.fill()

        let height = rect.height * CGFloat(progress)
        let newRect = CGRect(x: rect.origin.x,
                             y: rect.height - height,
                             width: rect.width,
                             height: height)
        let progressPath = UIBezierPath(roundedRect: newRect, cornerRadius: 4.0)
        Asset.Color.white.color.setFill()
        progressPath.fill()
    }
}
