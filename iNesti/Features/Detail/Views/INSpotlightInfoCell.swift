//
//  INSpotlightInfoCell.swift
//  iNesti
//
//  Created by Zian Chen on 6/2/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

class INSpotlightInfoCell: UITableViewCell {

    @IBOutlet weak var stackView1: UIStackView!
    @IBOutlet weak var stackView2: UIStackView!
    private var isEmpty = true
    
    var spotlightItemInfo = [INSpotlightItemInfo]()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView1.distribution = .fillEqually
        stackView2.distribution = .fillEqually
    }
    
    func setItemInfo(itemInfo: [INSpotlightItemInfo]) {
        spotlightItemInfo = itemInfo
        
        if isEmpty {
            for i in 0..<itemInfo.count {
                let info = itemInfo[i]
                let infoView = INItemSpotlightView()
                infoView.setInfo(info: info)
                if (i % 2 == 0) {
                    stackView1.addArrangedSubview(infoView)
                } else {
                    stackView2.addArrangedSubview(infoView)
                }
            }
            isEmpty = false
        }
    }
}
