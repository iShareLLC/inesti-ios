//
// Created by Cunqi Xiao on 5/10/18.
// Copyright (c) 2018 iShareLLC. All rights reserved.
//

import UIKit

enum CXFontType {
    case regular
    case semibold

    var fontName: String {
        switch self {
        case .regular:
            return "PingFangSC-Regular"
        case .semibold:
            return "PingFangSC-Semibold"
        }
    }
}

extension UIFont {
    static func getPingFangSC(with size: CGFloat, for type: CXFontType) -> UIFont {
        return UIFont(name: type.fontName, size: size)!
    }
}
