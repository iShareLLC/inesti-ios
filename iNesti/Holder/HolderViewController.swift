//
//  HolderViewController.swift
//  iNesti
//
//  Created by Cunqi Xiao on 5/9/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class HolderViewController: BaseViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var profileButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
}

extension HolderViewController: DZNEmptyDataSetSource {
    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
//        let registrationView = HolderRegistrationView.loadFromNib()
//        return registrationView
        let publishView = HolderPublishView.loadFromNib()
        return publishView
    }
}

extension HolderViewController: DZNEmptyDataSetDelegate {

}
