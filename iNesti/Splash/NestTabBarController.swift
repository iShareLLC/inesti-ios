//
//  NestTabBarController.swift
//  iNesti
//
//  Created by Cunqi Xiao on 5/9/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

enum MainNavigationSegue: String {
    // Home page
    case rentalDetailSegue = "RentalDetailSegue"
}

class NestTabBarController: UITabBarController {
    
    public func handleMainNavigationSegue(segue: MainNavigationSegue, sender: Any?) {
        self.performSegue(withIdentifier: segue.rawValue, sender: sender)
    }
}
