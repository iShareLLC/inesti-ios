//
//  RentalContactViewController.swift
//  iNesti
//
//  Created by Zian Chen on 5/30/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

protocol RentalContactViewControllerDelegate: class {
    func handleDismiss()
}

class RentalContactViewController: UIViewController {

    @IBOutlet weak var contactViewContainer: UIView!
    weak var delegate: RentalContactViewControllerDelegate?
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            let hitView = self.view.hitTest(firstTouch.location(in: self.view), with: event)
            if hitView != self.contactViewContainer {
                delegate?.handleDismiss()
            }
        }
    }
}
