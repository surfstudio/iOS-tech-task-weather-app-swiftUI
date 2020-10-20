//
//  UIView+Parallax.swift
//  Weather
//
//  Created by Александр Кравченков on 19.10.2020.
//

import UIKit

extension UIView {
    func addParalax(with offset: CGFloat) {

        guard self.motionEffects.isEmpty else { return }

        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -offset
        horizontal.maximumRelativeValue = offset

        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -offset
        vertical.maximumRelativeValue = offset

        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]

        self.addMotionEffect(group)
    }
}
