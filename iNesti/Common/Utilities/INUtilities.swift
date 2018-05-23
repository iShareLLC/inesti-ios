//
//  INUtilities.swift
//  iNesti
//
//  Created by Chen, Zian on 5/21/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

class INUtilities: NSObject {
    
    public static func instantiateViewContorller(id: String, storyboardId: String) -> UIViewController {
        return UIStoryboard(name: storyboardId, bundle: nil).instantiateViewController(withIdentifier: id)
    }
}
