//
//  AddRentalTagEntryViewController.swift
//  iNesti
//
//  Created by Chen, Zian on 5/21/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit
import TTGTagCollectionView

class AddRentalTagEntryViewController: BaseViewController {

    let rentalTagCellId = "RentalTagCell"
    let rentalTrafficCellId = "RentalTrafficCell"
    
    @IBOutlet weak var rentIncludedTagView: TTGTextTagCollectionView!
    @IBOutlet weak var rentRequiredTagView: TTGTextTagCollectionView!
    @IBOutlet weak var roomIncludedTagView: TTGTextTagCollectionView!
    @IBOutlet weak var buildingSpecsTagView: TTGTextTagCollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    let titleValues = ["租费包括", "租房要求", "房间概括", "公寓楼概括"]
    let tagValues = [rentIncludedTagsValues, rentRequiredTagsValues, roomIncludedTagsValues, buildingSpecsValues]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 80;
    }
}

extension AddRentalTagEntryViewController: UITableViewDelegate {
    
}

extension AddRentalTagEntryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row != 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: rentalTagCellId, for: indexPath) as! RentalTagCell
            cell.titleLabel.text = titleValues[indexPath.row]
            cell.setTags(tags: tagValues[indexPath.row], row: indexPath.row)
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: rentalTrafficCellId, for: indexPath) as! RentalTrafficCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagValues.count + 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 4 {
            return UITableViewAutomaticDimension
        } else {
            return 310
        }
    }
}

extension AddRentalTagEntryViewController: RentalTagCellDelegate {
    
    func rentalTagSelected(row: Int, tagIndex: Int) {
        print("row:\(row), tag: \(tagIndex)")
    }
    
}

protocol RentalTagCellDelegate: class {
    func rentalTagSelected(row: Int, tagIndex: Int)
}

class RentalTagCell: UITableViewCell {
    
    @IBOutlet weak var tagView: TTGTextTagCollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    weak var delegate: RentalTagCellDelegate?
    var rowIndex: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tagView.alignment = .left
        tagView.manualCalculateHeight = true;
        tagView.delegate = self
        self.selectionStyle = .none
        
        if let config = tagView.defaultConfig {
            config.tagTextColor = UIColor.in_textGray
            config.tagSelectedTextColor = UIColor.black
            config.tagBackgroundColor = UIColor.white
            config.tagSelectedBackgroundColor = UIColor.in_yellow
            config.tagCornerRadius = 16.0
            config.tagSelectedCornerRadius = 16.0
            config.tagBorderWidth = 1
            config.tagSelectedBorderWidth = 1
            config.tagBorderColor = UIColor.in_textGray
            config.tagSelectedBorderColor = UIColor.in_textGray
            config.tagShadowOpacity = 0
        }
    }
    
    func setTags(tags: [String], row: Int) {
        tagView.removeAllTags()
        tagView.addTags(tags)
        rowIndex = row
    }
}

extension RentalTagCell: TTGTextTagCollectionViewDelegate {
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTapTag tagText: String!, at index: UInt, selected: Bool, tagConfig config: TTGTextTagConfig!) {
        
        self.delegate?.rentalTagSelected(row: rowIndex, tagIndex: Int(index))
    }
}

class RentalTrafficCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
}
