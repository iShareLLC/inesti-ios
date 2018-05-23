//
//  ProfileManager.swift
//  iNesti
//
//  Created by Chen, Zian on 5/23/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import Foundation


class ProfileManager: NSObject {
    
    static let shared = ProfileManager()
    
    private var isLoggedIn: Bool = true
    
    public func getIsLoggedIn() -> Bool {
        return isLoggedIn
    }
    
    public func setIsLoggined(isLogin: Bool) {
        isLoggedIn = isLogin
        if isLogin {
            NotificationCenter.default.post(name: .UserDidLogin, object: nil)
        } else {
            NotificationCenter.default.post(name: .UserDidLogout, object: nil)
        }
    }
}
