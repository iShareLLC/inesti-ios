//
//  INPageControlView.swift
//  iNesti
//
//  Created by Zian Chen on 5/27/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

protocol INPageControlViewDelegate: class {
    func pageControlTappedIndex(index: Int)
}

class INPageControlView: UIView {

    @IBOutlet var pageButtons: [UIButton]!
    weak var delegate: INPageControlViewDelegate?
    
    @IBAction func handlePageButton(sender: UIButton) {
        delegate?.pageControlTappedIndex(index: sender.tag)
    }

    func setIndex(index: Int) {
        //TODO: Set index
    }

}
