//
//  LoginViewController.swift
//  iNesti
//
//  Created by Zian Chen on 6/16/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    private var isLoading = false {
        didSet {
            if isLoading {
                loadingIndicator.startAnimating()
            } else {
                loadingIndicator.stopAnimating()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handleBackButton(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleSubmit(sender: UIButton) {
        submit()
    }
    
    private func submit() {
        guard validation() else {
            return
        }
        
        guard let email = emailTextField.text,
            let password = passwordTextField.text else {
                return
        }
        
        isLoading = true
        ProfileManager.shared.login(email: email, password: password) { (success) in
            self.isLoading = false
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.displayAlert(title: "登入失败", message: "登入失败，请重新输入正确的用户名和密码。", completion: nil)
            }
        }
    }
    
    private func validation() -> Bool {
        guard let email = emailTextField.text, !email.isEmpty else {
            self.displayAlertOkCancel(title: "电邮不能为空", message: "请输入你的电邮。", completion: nil)
            return false
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            self.displayAlertOkCancel(title: "密码不能为空", message: "请输入密码。", completion: nil)
            return false
        }
        
        return true
    }
}
