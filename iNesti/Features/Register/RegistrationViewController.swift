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
    
    @IBOutlet weak var passwordTextField: INTextField!
    @IBOutlet weak var confirmTextField: INTextField!
    
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
        
        guard validation() else {
            return
        }
        
        //TODO: Add submit method
        ProfileManager.shared.setIsLoggined(isLogin: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    private func validation() -> Bool {
        
        guard passwordTextField.text == confirmTextField.text else {
            self.displayAlertOkCancel(title: "密码不符", message: "密码和确认密码不符合，请重新输入") { [weak self] _ in
                self?.passwordTextField.text = nil
                self?.confirmTextField.text = nil
            }
            return false
        }
        
        guard let password = passwordTextField.text, password.count >= 6 else {
            self.displayAlertOkCancel(title: "密码数太少", message: "密码必须是6位以上", completion: nil)
            return false
        }
        
        return true
    }
}
