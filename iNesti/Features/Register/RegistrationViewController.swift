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
    
    @IBOutlet weak var emailTextField: INTextField!
    @IBOutlet weak var usernameTextField: INTextField!
    @IBOutlet weak var areaCodeTextField: INTextField!
    @IBOutlet weak var phoneTextField: INTextField!
    @IBOutlet weak var passwordTextField: INTextField!
    @IBOutlet weak var confirmTextField: INTextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
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
        
        guard let email = emailTextField.text,
        let username = usernameTextField.text,
        let password = passwordTextField.text,
        let code = areaCodeTextField.text,
        let phone = phoneTextField.text else {
            return
        }
        
        //TODO: Add submit method
        ProfileManager.shared.register(email: email, username: username, password: password, phone: code + phone) { (success, status) in
            if success {
                self.displayAlert(title: "注册成功", message: "欢迎使用iNest，你可以开始添加房源啦。", completion: { [weak self] (style) in
                    self?.dismiss(animated: true, completion: nil)
                })
            } else {
                var reason = "用户名已注册"
                if status == 409 {
                    reason = "电邮已注册"
                } else if status == 410 {
                    reason = "用户名已注册"
                }
                self.displayAlert(title: "注册失败", message: reason, completion: nil)
            }
        }
    }
    
    private func validation() -> Bool {
        
        guard let username = usernameTextField.text, username.count >= 6 else {
            self.displayAlertOkCancel(title: "用户名字符太少", message: "用户名必须有6位字符以上。", completion: nil)
            return false
        }
        
        guard let email = emailTextField.text, email.isValidEmail() else {
            self.displayAlertOkCancel(title: "电邮格式问题", message: "请检查电邮格式是否正确。", completion: nil)
            return false
        }
        
        guard let areaCode = areaCodeTextField.text, !areaCode.isEmpty else {
            self.displayAlertOkCancel(title: "地区号为空", message: "请输入电话地区号。", completion: nil)
            return false
        }
        
        guard let phone = phoneTextField.text, phone.count >= 7 else {
            self.displayAlertOkCancel(title: "电话号长度过短", message: "请输入正确电话号。", completion: nil)
            return false
        }
        
        guard passwordTextField.text == confirmTextField.text else {
            self.displayAlertOkCancel(title: "密码不符", message: "密码和确认密码不符合，请重新输入。") { [weak self] _ in
                self?.passwordTextField.text = nil
                self?.confirmTextField.text = nil
            }
            return false
        }
        
        guard let password = passwordTextField.text, password.count >= 6 else {
            self.displayAlertOkCancel(title: "密码字符太少", message: "密码必须是6位字符以上。", completion: nil)
            return false
        }
        
        return true
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.scrollRectToVisible(textField.frame, animated: true)
    }
}
