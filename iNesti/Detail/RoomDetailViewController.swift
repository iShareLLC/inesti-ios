//
//  RoomDetailViewController.swift
//  iNesti
//
//  Created by Cunqi Xiao on 5/8/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa
import ExpandableLabel

class MockSummary: RoomSummaryDisplayable {
    var area: String {
        return "布鲁克林"
    }

    var title: String {
        return "位于皇冠高度区的精装公寓"
    }

    var description: String {
        return "精装修，带家具，独立厨卫，包水电暖网络；交通方便，生活便利，房子干净整洁。步行距离内, 精装修，带家具，独立厨卫，包水电暖网络；交通方便，生活便利，房子干净整洁。步行距离内"
    }
}

class RoomDetailViewController: BaseViewController, CXStoryboardLoadable {
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(cellType: RoomGalleryCell.self)
        tableView.register(cellType: RoomSummaryCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension RoomDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath == RoomGalleryCell.indexPath {
            return tableView.dequeueReusableCell(for: indexPath, cellType: RoomGalleryCell.self)
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: RoomSummaryCell.self)
            cell.setup(with: MockSummary(), delegate: self)
            return cell
        }
    }
}

extension  RoomDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return RoomGalleryCell.cellHeight
        } else {
            return UITableViewAutomaticDimension
        }
    }
}

extension RoomDetailViewController: ExpandableLabelDelegate {
    func didExpandLabel(_ label: ExpandableLabel) {
        tableView.reloadRows(at: [RoomSummaryCell.indexPath], with: .none)
    }

    func willExpandLabel(_ label: ExpandableLabel) {
    }

    func willCollapseLabel(_ label: ExpandableLabel) {
        
    }

    func didCollapseLabel(_ label: ExpandableLabel) {
        tableView.reloadRows(at: [RoomSummaryCell.indexPath], with: .none)
    }
}
