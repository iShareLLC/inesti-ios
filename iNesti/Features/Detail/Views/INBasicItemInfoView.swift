//
//  INBasicItemInfoView.swift
//  iNesti
//
//  Created by Zian Chen on 6/2/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

class INBasicItemInfoView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var isAvailableIcon: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("INBasicItemInfoView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func setInfo(info: INBasicItemInfo) {
        nameLabel.text = info.name
        isAvailableIcon.image = info.isAvaialble ? UIImage(named: "yes") : UIImage(named: "no")
        setNeedsLayout()
    }

}

struct INBasicItemInfo {
    let name: String
    let isAvaialble: Bool
}
