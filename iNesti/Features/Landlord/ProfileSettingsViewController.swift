//
//  ProfileSettingsViewController.swift
//  iNesti
//
//  Created by Zian Chen on 5/27/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

class ProfileSettingsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            //Where logout is
            logout()
        }
    }
    
    //MARK: ACTION HANDLER
    @IBAction func handleBackButton(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: HELPER
    func logout() {
        displayAlertOkCancel(title: "登出", message: "是否确认登出？") { (style) in
            if style == .default {
                ProfileManager.shared.setIsLoggined(isLogin: false)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

}
