//
//  INBasicInfoCell.swift
//  iNesti
//
//  Created by Zian Chen on 6/2/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

class INBasicInfoCell: UITableViewCell {
    @IBOutlet weak var stackView1: UIStackView!
    @IBOutlet weak var stackView2: UIStackView!
    
    var basicItemInfo = [INBasicItemInfo]()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView1.distribution = .fillEqually
        stackView2.distribution = .fillEqually
    }
    
    func setItemInfo(itemInfo: [INBasicItemInfo]) {
        basicItemInfo = itemInfo
        
        for i in 0..<itemInfo.count {
            let info = itemInfo[i]
            let infoView = INBasicItemInfoView()
            infoView.setInfo(info: info)
            if (i % 2 == 0) {
                stackView1.addArrangedSubview(infoView)
            } else {
                stackView2.addArrangedSubview(infoView)
            }
        }
    }
}
