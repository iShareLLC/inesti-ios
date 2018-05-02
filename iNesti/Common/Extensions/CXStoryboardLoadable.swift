//
//  CXStoryboardLoadable.swift
//  iNesti
//
//  Created by Cunqi Xiao on 5/2/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

protocol CXStoryboardLoadable: class {
    static var storyboardID: String { get }
}

extension CXStoryboardLoadable where Self: UIViewController {
    static var storyboardID: String {
        return String(describing: self)
    }
}

extension UIStoryboard {
    func instantiateInitial() -> UIViewController? {
        return self.instantiateInitialViewController()
    }

    func instantiate<T: CXStoryboardLoadable>(for viewController: T.Type) -> T {
        return self.instantiateViewController(withIdentifier: viewController.storyboardID) as! T
    }
}
