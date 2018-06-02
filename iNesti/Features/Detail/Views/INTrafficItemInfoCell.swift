//
//  INTrafficItemInfoCell.swift
//  iNesti
//
//  Created by Zian Chen on 6/2/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

class INTrafficItemInfoCell: UITableViewCell {

    @IBOutlet weak var stackView1: UIStackView!
    @IBOutlet weak var stackView2: UIStackView!
    private var isEmpty = true
    
    var spotlightItemInfo = [INSpotlightItemInfo]()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView1.distribution = .fillEqually
        stackView2.distribution = .fillEqually
    }
    
    func setItemInfo(itemInfo: [INSpotlightItemInfo], trafficInfo: [String]) {
        spotlightItemInfo = itemInfo
        
        if isEmpty {
            for info in itemInfo {
                let infoView = INItemSpotlightView()
                infoView.setInfo(info: info)
                stackView1.addArrangedSubview(infoView)
            }
            
            for traffic in trafficInfo {
                let trafficLabel = UILabel()
                trafficLabel.text = traffic
                trafficLabel.font = UIFont(name: trafficLabel.font.fontName, size: 14)
                trafficLabel.textAlignment = .right
                stackView2.addArrangedSubview(trafficLabel)
            }
            
            isEmpty = false
        }
    }
}
