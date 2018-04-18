//
//  String+Localization.swift
//  iNesti
//
//  Created by Cunqi Xiao on 4/17/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }

    var webURL: URL? {
        return try? self.asURL()
    }
}

