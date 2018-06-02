//
//  RentalContactViewController.swift
//  iNesti
//
//  Created by Zian Chen on 5/30/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit
import Messages
import MessageUI

protocol RentalContactViewControllerDelegate: class {
    func handleDismiss()
}

class RentalContactViewController: UIViewController {

    @IBOutlet weak var contactViewContainer: UIView!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var copyButton: UIButton!
    
    weak var delegate: RentalContactViewControllerDelegate?
    let contact = RentalContact(phone: "(718)566-3380", wechat: "zianabc1234", email: "doomon@gmail.com")
    
    //MARK: Action Handler
    @IBAction func handleCopyButton(sender: UIButton) {
        UIPasteboard.general.string = contact.wechat
        self.displayAlert(title: "复制微信号", message: "复制\"\(contact.wechat)\"至黏贴簿", completion: nil)
    }
    
    @IBAction func handlePhoneButton(sender: UIButton) {
        if let url = URL(string: "tel://\(contact.phone)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            DLog("Wrong phone number")
        }
    }
    
    @IBAction func handleEmailButton(sender: UIButton) {
        
        if MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            // Configure the fields of the interface.
            composeVC.setToRecipients([contact.email])
            composeVC.setSubject("iNesti Rental")
            composeVC.setMessageBody("Hey I am interested at your rental listing!", isHTML: false)
            
            // Present the view controller modally.
            self.present(composeVC, animated: true, completion: nil)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            let hitView = self.view.hitTest(firstTouch.location(in: self.view), with: event)
            if hitView != self.contactViewContainer {
                delegate?.handleDismiss()
            }
        }
    }
}

extension RentalContactViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
}

struct RentalContact {
    let phone: String
    let wechat: String
    let email: String
}
