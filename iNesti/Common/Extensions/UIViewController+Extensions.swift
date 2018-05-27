//
//  UIViewController+Extensions.swift
//  iNesti
//
//  Created by Zian Chen on 5/27/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func displayAlertOkCancel(title: String, message: String, completion:((UIAlertActionStyle) -> Void)?) {
        let v = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            completion?(action.style)
        }
        let okAction = UIAlertAction(title: "确认", style: .default) { (action) in
            completion?(action.style)
        }
        v.addAction(cancelAction)
        v.addAction(okAction)
        
        present(v, animated: true, completion: nil)
    }
    
}
