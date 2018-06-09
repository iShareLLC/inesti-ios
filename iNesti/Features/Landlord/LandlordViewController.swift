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
    @IBOutlet weak var unpublishedButton: UIButton!
    @IBOutlet weak var footerView: LandlordPublishFooterView!

    //var dataSource = ["1", "2", "3"]
    var dataSource = [Rental]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        footerView.delegate = self
        footerView.isHidden = !ProfileManager.shared.getIsLoggedIn()
        
        dataSource = RentalDataStore.shared.getRentals(state: .published)
        
        updateProfileButtons(isLoggedIn: ProfileManager.shared.getIsLoggedIn())
        
        NotificationCenter.default.addObserver(forName: .UserDidChange, object: nil, queue: nil) {[weak self] _ in
            
            if ProfileManager.shared.getIsLoggedIn() {
                self?.dataSource = RentalDataStore.shared.getRentals(state: .published)
            } else {
                self?.dataSource.removeAll()
            }
            
            self?.footerView.isHidden = !ProfileManager.shared.getIsLoggedIn()
            self?.tableView.reloadData()
            self?.updateProfileButtons(isLoggedIn: ProfileManager.shared.getIsLoggedIn())
        }
        
        NotificationCenter.default.addObserver(forName: .DataStoreDidUpdate, object: nil, queue: nil) {[weak self] _ in
            if ProfileManager.shared.getIsLoggedIn() {
                self?.dataSource = RentalDataStore.shared.getRentals(state: .published)
                self?.tableView.reloadData()
            }
        }
    }
    
    private func updateProfileButtons(isLoggedIn: Bool)  {
        profileButton.isHidden = !ProfileManager.shared.getIsLoggedIn()
        unpublishedButton.isHidden = !ProfileManager.shared.getIsLoggedIn()
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
        
        if ProfileManager.shared.getIsLoggedIn() {
            if isEmptyData() {
                let cell: LandlordNoItemCell = tableView.dequeueReusableCell(withIdentifier: "LandlordNoItemCell", for: indexPath) as! LandlordNoItemCell
                cell.selectionStyle = .none
                return cell
            } else {
                let rental = dataSource[indexPath.row]
                let cell = tableView.dequeueReusableCell(withIdentifier: "LandlordRentalCell", for: indexPath) as! LandlordRentalCell
                cell.selectionStyle = .none
                cell.delegate = self
                cell.rental = rental
                return cell
            }
            
        } else {
            let cell: LandlordNoLoginCell = tableView.dequeueReusableCell(withIdentifier: "LandlordNoLoginCell", for: indexPath) as! LandlordNoLoginCell
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if ProfileManager.shared.getIsLoggedIn() {
            if isEmptyData() {
                return 200
            } else {
                return 320
            }
        } else {
            return 400
        }
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

extension LandlordViewController: LandlordRentalCellDelegate {
    
    func handleEdit(rental: Rental) {
        DLog("Edit Rental")
    }
    
    func handleDelete(rental: Rental) {
        DLog("Delete Rental")
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


protocol LandlordRentalCellDelegate: class {
    func handleEdit(rental: Rental)
    func handleDelete(rental: Rental)
}

class LandlordRentalCell: UITableViewCell {
    
    weak var delegate: LandlordRentalCellDelegate?
    var rental: Rental?
    
    @IBAction func handleEditButton(sender: UIButton) {
        guard let rental = rental else { return }
        delegate?.handleEdit(rental: rental)
    }
    
    @IBAction func handleDeleteButton(sender: UIButton) {
        guard let rental = rental else { return }
        delegate?.handleDelete(rental: rental)
    }
}

