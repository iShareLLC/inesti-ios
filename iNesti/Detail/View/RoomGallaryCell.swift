//
//  RoomGallaryCell.swift
//  iNesti
//
//  Created by Cunqi Xiao on 5/8/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit
import Reusable

protocol RoomGallaryDisplayable {
    var availableStartDate: Date { get }
    var duration: String { get }
    var roomImageUrls: [String] { get }
}

class RoomGallaryCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var availableDateTimeLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private   weak var pageIndicator: UIPageControl!

    func setup(with roomGallary: RoomGallaryDisplayable) {
        pageIndicator.numberOfPages = roomGallary.roomImageUrls.count == 1 ? 0 : roomGallary.roomImageUrls.count
    }

    private func createAttributedString(for date: String) -> NSAttributedString {
        let title = NSAttributedString(string: "开放时间", attributes: [NSAttributedStringKey.font: UIFont(name: "PingFangSC-Semibold", size: 9.0), NSAttributedStringKey.foregroundColor: UIColor.textSecondaryGary])
        return title
    }
}
