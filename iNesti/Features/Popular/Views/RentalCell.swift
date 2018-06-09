//
//  RentalCell.swift
//  iNesti
//
//  Created by Zian Chen on 5/24/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit
import AlamofireImage

class RentalCell: UITableViewCell {
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var areaLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!
    @IBOutlet private weak var container: UIView!
    
    private var isShadowAdded = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //addShadow()
    }
    
    func setup(item: RentalListItem) {
        priceLabel.text = item.priceString()
        areaLabel.text = item.title1
        titleLabel.text = item.title2
        summaryLabel.text = item.description
        if let image = item.imageUrls.first, let imageUrl = URL(string: image) {
            coverImageView.af_setImage(withURL: imageUrl)
        }
    }
    
    func addShadow() {
        guard !isShadowAdded else {
            return
        }
        let maskPath = UIBezierPath(roundedRect: coverImageView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 4.0, height: 4.0))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        maskLayer.frame = coverImageView.bounds
        coverImageView.layer.mask = maskLayer
        
        container.layer.cornerRadius = 4
        container.layer.applySketchShadow(color: UIColor(white: 0, alpha: 0.25), x: 0, y: 6, blur: 20, spread: 0)
        isShadowAdded = true
    }
}
