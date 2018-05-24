//
//  Notification+Extensions.swift
//  iNesti
//
//  Created by Chen, Zian on 5/23/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import Foundation

public extension Notification.Name {
    public static let UserDidLogin = Notification.Name(rawValue: "com.inesti.users.didLogin")
    public static let UserDidLogout = Notification.Name(rawValue: "com.inesti.users.didLogout")
    
    public static let DataStoreDidUpdate = Notification.Name(rawValue: "com.inesti.dataStore.didUpdate")
    
}
