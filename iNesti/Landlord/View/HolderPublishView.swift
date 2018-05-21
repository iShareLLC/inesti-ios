//
//  HolderPublishView.swift
//  iNesti
//
//  Created by Cunqi Xiao on 5/9/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit
import Reusable

protocol HolderPublishViewDelegate: class {
    func addNewRentalButtonTapped()
}

class HolderPublishView: UIView, NibLoadable {
    
    @IBOutlet private weak var actionButton: UIButton!
    weak var delegate: HolderPublishViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        actionButton.layer.cornerRadius = 3.0
        actionButton.layer.masksToBounds = false
        actionButton.layer.applySketchShadow(color: UIColor(white: 0, alpha: 0.13), x: 0, y: 2, blur: 3, spread: 0)
    }
    
    @IBAction func handleAddNewRentalButton(sender: UIButton) {
        delegate?.addNewRentalButtonTapped()
    }
}

