//
//  LandlordViewController.swift
//  iNesti
//
//  Created by Cunqi Xiao on 5/9/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class LandlordViewController: BaseViewController {
    
    let kNewRentalSegue = "NewRentalSegue"
    let kRegistrationSegue = "RegistrationSegue"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var footerView: LandlordPublishFooterView!

    //var dataSource = ["1", "2", "3"]
    var dataSource = RentalDataStore.shared.getRentals(state: .published)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        footerView.delegate = self
        footerView.setType(viewType: (ProfileManager.shared.getIsLoggedIn()) ? .newRental : .registration)
        
        NotificationCenter.default.addObserver(forName: .UserDidLogin, object: nil, queue: nil) {[weak self] _ in
            self?.footerView.setType(viewType: .newRental)
        }
        
        NotificationCenter.default.addObserver(forName: .DataStoreDidUpdate, object: nil, queue: nil) {[weak self] _ in
            self?.dataSource = RentalDataStore.shared.getRentals(state: .published)
            self?.tableView.reloadData()
        }
    }
}

extension LandlordViewController: UITableViewDelegate {
    
}

extension LandlordViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isEmptyData() ? 1 : dataSource.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isEmptyData() {
            let cell: LandlordNoItemCell = tableView.dequeueReusableCell(withIdentifier: "LandlordNoItemCell", for: indexPath) as! LandlordNoItemCell
            
            if ProfileManager.shared.getIsLoggedIn() {
                cell.setMessage(message: "您还没有已发布的房源，点击 “添加房源” 按钮开始添加。")
            } else {
                cell.setMessage(message: "发布房源之前，你需要注册账户。")
            }
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "LandlordRentalCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isEmptyData() {
            return 200
        }
        return 320
    }
    
    //MARK: HELPER
    private func isEmptyData() -> Bool {
        return dataSource.count == 0
    }
}

extension LandlordViewController: LandlordPublishFooterViewDelegate {
    
    func footerActionButtonHandler(viewType: LandlordPublishFooterView.FooterViewType) {
        if viewType == .registration {
            performSegue(withIdentifier: kRegistrationSegue, sender: nil)
        } else {
            performSegue(withIdentifier: kNewRentalSegue, sender: nil)
        }
    }
}


protocol LandlordPublishFooterViewDelegate: class {
    func footerActionButtonHandler(viewType: LandlordPublishFooterView.FooterViewType)
}

class LandlordPublishFooterView: UITableViewHeaderFooterView {
    
    enum FooterViewType {
        case registration, newRental
    }
    
    @IBOutlet private weak var actionButton: UIButton!
    
    weak var delegate: LandlordPublishFooterViewDelegate?
    private var type: FooterViewType = .registration
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        actionButton.layer.cornerRadius = 3.0
        actionButton.layer.masksToBounds = false
        actionButton.layer.applySketchShadow(color: UIColor(white: 0, alpha: 0.13), x: 0, y: 2, blur: 3, spread: 0)
    }
    
    @IBAction func handleActionButton(sender: UIButton) {
        delegate?.footerActionButtonHandler(viewType: type)
    }
    
    public func setType(viewType: FooterViewType) {
        type = viewType
        if viewType == .registration {
            actionButton.setImage(nil, for: .normal)
            actionButton.setTitle("注册用户", for: .normal)
        } else {
            actionButton.setImage(UIImage(named: "add"), for: .normal)
            actionButton.setTitle("添加房源", for: .normal)
        }
    }
}

class LandlordNoItemCell: UITableViewCell {
    @IBOutlet private weak var messageLabel: UILabel!
    
    public func setMessage(message: String) {
        messageLabel.text = message
    }
}
