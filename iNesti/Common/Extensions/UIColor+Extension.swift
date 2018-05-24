//
//  UIColor+Extension.swift
//  iNesti
//
//  Created by Cunqi Xiao on 5/8/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

extension UIColor {
    static var in_yellow: UIColor {
        return UIColor.color(r: 254, g: 203, b: 16)
    }

    static var in_textGray: UIColor {
        return UIColor.color(r: 51, g: 51, b: 51, a: 0.55)
    }

    static func color(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
}
