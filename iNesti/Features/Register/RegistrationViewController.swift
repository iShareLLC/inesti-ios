//
//  RegistrationViewController.swift
//  iNesti
//
//  Created by Zian Chen on 5/23/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit
import M13Checkbox

class RegistrationViewController: UIViewController {

    @IBOutlet weak var wechatCheckbox: M13Checkbox!
    @IBOutlet weak var emailCheckbox: M13Checkbox!
    @IBOutlet weak var phoneCheckbox: M13Checkbox!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wechatCheckbox.tintColor = UIColor.in_yellow
        wechatCheckbox.boxType = .square
        wechatCheckbox.addTarget(self, action: #selector(handleCheckbox(sender:)), for: .valueChanged)
        
        emailCheckbox.tintColor = UIColor.in_yellow
        emailCheckbox.boxType = .square
        emailCheckbox.addTarget(self, action: #selector(handleCheckbox(sender:)), for: .valueChanged)
        
        phoneCheckbox.tintColor = UIColor.in_yellow
        phoneCheckbox.boxType = .square
        phoneCheckbox.addTarget(self, action: #selector(handleCheckbox(sender:)), for: .valueChanged)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleBackButton(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleSubmitButton(sender: UIButton) {
        submit()
    }
    
    @objc func handleCheckbox(sender: M13Checkbox) {
        if sender == wechatCheckbox {
            DLog("Wechat checkbox checked: \(sender.checkState.rawValue)")
            
        } else if sender == emailCheckbox {
            DLog("Email checkbox checked: \(sender.checkState.rawValue)")
            
        } else if sender == phoneCheckbox {
            DLog("Phone checkbox checked: \(sender.checkState.rawValue)")
            
        }
    }
    
    private func submit() {
        //TODO: Add submit method
        ProfileManager.shared.setIsLoggined(isLogin: true)
        self.dismiss(animated: true, completion: nil)
    }
}
