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
        footerView.isHidden = !ProfileManager.shared.getIsLoggedIn()
        
        updateProfileButton(isLoggedIn: ProfileManager.shared.getIsLoggedIn())
        
        NotificationCenter.default.addObserver(forName: .UserDidChange, object: nil, queue: nil) {[weak self] _ in
            self?.footerView.isHidden = !ProfileManager.shared.getIsLoggedIn()
            self?.tableView.reloadData()
            self?.updateProfileButton(isLoggedIn: ProfileManager.shared.getIsLoggedIn())
        }
        
        NotificationCenter.default.addObserver(forName: .DataStoreDidUpdate, object: nil, queue: nil) {[weak self] _ in
            self?.dataSource = RentalDataStore.shared.getRentals(state: .published)
            self?.tableView.reloadData()
        }
    }
    
    private func updateProfileButton(isLoggedIn: Bool)  {
        if (ProfileManager.shared.getIsLoggedIn()) {
            profileButton.isUserInteractionEnabled = true
            profileButton.alpha = 1
        } else {
            profileButton.isUserInteractionEnabled = false
            profileButton.alpha = 0.3
        }
    }
}

extension LandlordViewController: LandlordNoLoginCellDelegate {
    
    func handleWeChatButton(sender: UIButton) {
        DLog("Wechat tapped")
    }
    
    func handleLoginButton(sender: UIButton) {
        DLog("Login tapped")
    }
    
    func handleRegisterButton(sender: UIButton) {
        DLog("Register Tapped")
        performSegue(withIdentifier: kRegistrationSegue, sender: nil)
    }
}

extension LandlordViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isEmptyData() ? 1 : dataSource.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isEmptyData() {
            if ProfileManager.shared.getIsLoggedIn() {
                let cell: LandlordNoItemCell = tableView.dequeueReusableCell(withIdentifier: "LandlordNoItemCell", for: indexPath) as! LandlordNoItemCell
                cell.selectionStyle = .none
                return cell
            } else {
                let cell: LandlordNoLoginCell = tableView.dequeueReusableCell(withIdentifier: "LandlordNoLoginCell", for: indexPath) as! LandlordNoLoginCell
                cell.selectionStyle = .none
                cell.delegate = self
                return cell
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "LandlordRentalCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isEmptyData() {
            if ProfileManager.shared.getIsLoggedIn() {
                return 200
            } else {
                return 400
            }
        }
        return 320
    }
    
    //MARK: HELPER
    private func isEmptyData() -> Bool {
        return dataSource.count == 0
    }
}

extension LandlordViewController: LandlordPublishFooterViewDelegate {
    
    func addRentalHandler() {
        performSegue(withIdentifier: kNewRentalSegue, sender: nil)
    }
}


protocol LandlordPublishFooterViewDelegate: class {
    func addRentalHandler()
}

class LandlordPublishFooterView: UITableViewHeaderFooterView {
    
    enum FooterViewType {
        case registration, newRental
    }
    
    @IBOutlet private weak var actionButton: UIButton!
    
    weak var delegate: LandlordPublishFooterViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        actionButton.layer.cornerRadius = 3.0
        actionButton.layer.masksToBounds = false
        actionButton.layer.applySketchShadow(color: UIColor(white: 0, alpha: 0.13), x: 0, y: 2, blur: 3, spread: 0)
    }
    
    @IBAction func handleActionButton(sender: UIButton) {
        delegate?.addRentalHandler()
    }
}

class LandlordNoItemCell: UITableViewCell {
    
}

protocol LandlordNoLoginCellDelegate: class {
    func handleWeChatButton(sender: UIButton)
    func handleLoginButton(sender: UIButton)
    func handleRegisterButton(sender: UIButton)
}

class LandlordNoLoginCell: UITableViewCell {
    
    weak var delegate: LandlordNoLoginCellDelegate?
    
    @IBAction func handleWeChat(sender: UIButton) {
        delegate?.handleWeChatButton(sender: sender)
    }
    
    @IBAction func handleLogin(sender: UIButton) {
        delegate?.handleLoginButton(sender: sender)
    }
    
    @IBAction func handleRegister(sender: UIButton) {
        delegate?.handleRegisterButton(sender: sender)
    }
}

