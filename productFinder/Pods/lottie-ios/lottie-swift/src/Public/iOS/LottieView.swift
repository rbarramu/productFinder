//
//  LottieView.swift
//  lottie-swift-iOS
//
//  Created by Brandon Withrow on 2/6/19.
//

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS) || targetEnvironment(macCatalyst)
    import UIKit

    // public typealias LottieView = UIView

    open class LottieView: UIView {
        var viewLayer: CALayer? {
            layer
        }

        func layoutAnimation() {}

        func animationMovedToWindow() {}

        override open func didMoveToWindow() {
            super.didMoveToWindow()
            animationMovedToWindow()
        }

        var screenScale: CGFloat {
            UIScreen.main.scale
        }

        func commonInit() {
            contentMode = .scaleAspectFit
            clipsToBounds = true
            NotificationCenter.default.addObserver(self, selector: #selector(animationWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(animationWillMoveToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        }

        override open var contentMode: UIView.ContentMode {
            didSet {
                setNeedsLayout()
            }
        }

        override open func layoutSubviews() {
            super.layoutSubviews()
            layoutAnimation()
        }

        @objc func animationWillMoveToBackground() {}

        @objc func animationWillEnterForeground() {}
    }
#endif
