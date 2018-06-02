//
//  INItemSpotlightView.swift
//  iNesti
//
//  Created by Zian Chen on 6/2/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

class INItemSpotlightView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("INItemSpotlightView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func setInfo(info: INSpotlightItemInfo) {
        nameLabel.text = info.name
        icon.image = UIImage(named: info.iconName)
        setNeedsLayout()
    }
    
}

struct INSpotlightItemInfo {
    let name: String
    let iconName: String
}

