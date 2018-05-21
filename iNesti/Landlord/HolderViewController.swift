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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HolderViewController: UITableViewDelegate {
    
}

extension HolderViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LandlordRentalCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
}

extension HolderViewController: HolderPublishViewDelegate {
    
    func addNewRentalButtonTapped() {
        DLog("Button tapped, navigate to adding new rental page")
    }
    
}

protocol LandlordPublishFooterViewDelegate: class {
    func addNewRentalButtonTapped()
}

class LandlordPublishFooterView: UITableViewHeaderFooterView {
    
    @IBOutlet private weak var actionButton: UIButton!
    weak var delegate: LandlordPublishFooterViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        actionButton.layer.cornerRadius = 3.0
        actionButton.layer.masksToBounds = false
        actionButton.layer.applySketchShadow(color: UIColor(white: 0, alpha: 0.13), x: 0, y: 2, blur: 3, spread: 0)
    }
    
    @IBAction func handleAddNewRentalButton(sender: UIButton) {
        delegate?.addNewRentalButtonTapped()
    }
}
