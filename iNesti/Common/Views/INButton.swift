//
//  INButton.swift
//  iNesti
//
//  Created by Zian Chen on 6/9/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

class INButton: UIButton {

    override func draw(_ rect: CGRect) {
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }

}
