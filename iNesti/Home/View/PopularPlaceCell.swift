//
//  PopularPlaceCell.swift
//  iNesti
//
//  Created by Cunqi Xiao on 4/17/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher

class PopularPlaceCell: UICollectionViewCell, NibReusable {
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var areaLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!
    @IBOutlet private weak var container: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(with place: PopularPlace) {
        priceLabel.text = place.price
        areaLabel.text = place.area
        titleLabel.text = place.title
        summaryLabel.text = place.summary
        coverImageView.kf.setImage(with: place.imageUrls.first?.webURL)
    }

    func addShadow() {
        container.layer.cornerRadius = 4
        container.layer.applySketchShadow(color: UIColor(white: 0, alpha: 1), x: 0, y: 6, blur: 30, spread: 0)
    }
}
