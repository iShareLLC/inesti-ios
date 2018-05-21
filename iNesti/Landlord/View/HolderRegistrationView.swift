//
//  HolderRegistrationView.swift
//  iNesti
//
//  Created by Cunqi Xiao on 5/9/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit
import Reusable

class HolderRegistrationView: UIView, NibLoadable {
    @IBOutlet private weak var actionButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupActionButton()
    }

    private func setupActionButton() {
        actionButton.layer.cornerRadius = 3.0
        actionButton.layer.masksToBounds = false
        actionButton.layer.applySketchShadow(color: UIColor(white: 0, alpha: 0.13), x: 0, y: 2, blur: 3, spread: 0)
    }
}
