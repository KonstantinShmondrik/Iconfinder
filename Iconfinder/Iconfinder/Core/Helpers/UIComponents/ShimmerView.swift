//
//  ShimmerView.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 10.08.2024.
//

import UIKit

class ShimmerView: UIView {

    private let gradientLayer = CAGradientLayer()

    public nonisolated class var defaultColors: [CGColor] {
        return [
            AppColor.backgroundMinor.cgColor,
            AppColor.backgroundMain.cgColor,
            AppColor.backgroundMinor.cgColor
        ]
    }

    private let gradientColors: [CGColor]

    override func layoutSubviews() {
        super.layoutSubviews()

        gradientLayer.frame = bounds
    }

    public init(gradientColors: [CGColor] = defaultColors) {
        self.gradientColors = gradientColors
        super.init(frame: .zero)

        addGradientLayer()
    }

    func addGradientLayer() {
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = gradientColors
        gradientLayer.locations = [0.0, 0.5, 1.0]
        layer.addSublayer(gradientLayer)
    }

    func addAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1, -0.5, 0]
        animation.toValue = [1, 1.5, 2]
        animation.repeatCount = .infinity
        animation.duration = 0.9
        animation.isRemovedOnCompletion = false
        return animation
    }

    func startAnimating() {
        let animation = addAnimation()

        gradientLayer.add(animation, forKey: animation.keyPath)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
