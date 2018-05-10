//
//  RoomSummaryCell.swift
//  iNesti
//
//  Created by Cunqi Xiao on 5/9/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import ExpandableLabel

protocol RoomSummaryDisplayable {
    var area: String { get }
    var title: String { get }
    var description: String { get }
}

class RoomSummaryCell: UITableViewCell, NibReusable {
    static let indexPath = IndexPath(row: 0, section: 1)
    @IBOutlet private weak var areaLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var expandableLabel: ExpandableLabel!

    func setup(with displayable: RoomSummaryDisplayable, delegate: ExpandableLabelDelegate) {
        areaLabel.text = displayable.area
        titleLabel.text = displayable.title
        expandableLabel.text = displayable.description
        expandableLabel.delegate = delegate
        self.layoutIfNeeded()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupExpandableLabel()
    }

    private func setupExpandableLabel() {
        expandableLabel.font = UIFont.getPingFangSC(with: 14.0, for: .regular)
        expandableLabel.textAlignment = .left
        expandableLabel.numberOfLines = 2
        expandableLabel.collapsedAttributedLink = getReadMoreString()
        expandableLabel.setLessLinkWith(lessLink: "收起", attributes: [
            .font: UIFont.getPingFangSC(with: 14.0, for: .regular),
            .foregroundColor: UIColor.majorYellow
        ], position: nil)
        expandableLabel.ellipsis = NSAttributedString(string: "")
    }

    private func getReadMoreString() -> NSAttributedString {
        return NSAttributedString(string: "查看更多", attributes: [
            .font: UIFont.getPingFangSC(with: 14.0, for: .regular),
            .foregroundColor: UIColor.majorYellow
        ])
    }
}
