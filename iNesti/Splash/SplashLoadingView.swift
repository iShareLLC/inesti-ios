//
//  SplashLoadingView.swift
//  iNesti
//
//  Created by Cunqi Xiao on 5/9/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit
import Reusable
import CXPopupKit

class SplashLoadingView: UIView, NibLoadable {
    @IBOutlet weak var dot: UIView!

    private let appearance: CXAppearance = {
        var appearance = CXAppearance()
        appearance.window.width = .equalToParent
        appearance.window.height = .equalToParent
        appearance.window.allowTouchOutsideToDismiss = false
        appearance.window.isSafeAreaEnabled = false
        appearance.animation.duration = CXAnimation.Duration(in: 0.1, out: 0.35)
        appearance.animation.style = .fade
        appearance.animation.transition = CXAnimation.Transition(.center)
        return appearance
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
//        self.backgroundColor = UIColor.majorYellow

        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.fromValue = 1.0
        pulseAnimation.toValue = 5.0
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        pulseAnimation.duration = 1.5
        pulseAnimation.isRemovedOnCompletion = false
        pulseAnimation.repeatCount = MAXFLOAT
        pulseAnimation.fillMode = kCAFillModeBoth
        pulseAnimation.autoreverses = true

        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.fromValue = 0.8
        fadeAnimation.toValue = 0.25
        fadeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        fadeAnimation.duration = 1.5
        fadeAnimation.isRemovedOnCompletion = false
        fadeAnimation.repeatCount = MAXFLOAT
        fadeAnimation.fillMode = kCAFillModeBoth
        fadeAnimation.autoreverses = true

        dot.layer.add(pulseAnimation, forKey: pulseAnimation.keyPath)
        dot.layer.add(fadeAnimation, forKey: fadeAnimation.keyPath)
    }
}

extension SplashLoadingView: CXPopupable {
    func createPopup() -> CXPopup {
        return CXPopup(with: self, appearance: appearance)
    }
}
