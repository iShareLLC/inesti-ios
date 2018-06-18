//
//  ProfileManager.swift
//  iNesti
//
//  Created by Chen, Zian on 5/23/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import Foundation

let iNestiService = "iNestiService"

struct KeychainConfiguration {
    static let serviceName = iNestiService
    static let accessGroup: String? = nil
}

class ProfileManager: NSObject {
    
    static let shared = ProfileManager()
    
    private var isLoggedIn: Bool = false
    
    public func getIsLoggedIn() -> Bool {
        return isLoggedIn
    }
    
    private func setIsLoggined(isLogin: Bool) {
        let loginStatusDidChanged = (isLogin != isLoggedIn)
        isLoggedIn = isLogin
        if loginStatusDidChanged {
            NotificationCenter.default.post(name: .UserDidChange, object: isLogin)
        }
    }
    
    public func loadLocalUser() {
        if let _ = UserDefaults.getUsername(), let _ = readTokenFromKeychain() {
            self.setIsLoggined(isLogin: true)
            /*
            ApiServers.shared.getUserInfo(username: username, userToken: userToken, completion: { (homeProfileInfo, error) in
                if let error = error {
                    DLog("loadLocalUser Error: \(error.localizedDescription)")
                    completion?(false, error)
                    return
                }
                
                if let profileInfo = homeProfileInfo {
                    self.updateHomeProfileInfo(profileInfo, writeToKeychain: false)
                    completion?(true, nil)
                } else {
                    DLog("error: loadLocalUser: return user info is nil")
                    completion?(false, error)
                }
            })
             */
        }
    }
    
    public func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        APIManager.shared.postLogin(email: email, password: password) { (success, code, error) in
            if success {
                self.setIsLoggined(isLogin: true)
                UserDefaults.setUsername(email)
                self.saveTokenToKeychain(username: email, token: password)
            } else {
                self.setIsLoggined(isLogin: false)
            }
            completion(success)
        }
    }
    
    public func register(email: String, username: String, password: String, phone: String, wechatId: String? = nil, completion: @escaping (Bool, Int) -> Void) {
        APIManager.shared.postRegister(email: email, username: username, password: password, phone: phone, wechatId: wechatId) { (success, code, error) in
            if success {
                self.setIsLoggined(isLogin: true)
                UserDefaults.setUsername(email)
                self.saveTokenToKeychain(username: email, token: password)
            } else {
                self.setIsLoggined(isLogin: false)
            }
            completion(success, code)
        }
    }
    
    public func logout() {
        guard let email = UserDefaults.getUsername() else { return }
        self.deleteTokenFromKeychain(username: email)
        UserDefaults.setUsername(nil)
        setIsLoggined(isLogin: false)
    }
}

//User Token Related

extension ProfileManager {
    public func saveTokenToKeychain(username: String, token: String) {
        
        guard getIsLoggedIn() else {
            return
        }
        
        do {
            let userTokenItem = tokenItem(service: KeychainConfiguration.serviceName, account: username)
            try userTokenItem.savePassword(token)
        } catch {
            fatalError("⛔️ Error updating keychain for token - \(error)")
        }
    }
    
    fileprivate func readTokenFromKeychain() -> String? {
        
        var token: String? = nil
        
        if let username = UserDefaults.getUsername() {
            do {
                let userTokenItem = tokenItem(service: KeychainConfiguration.serviceName, account: username)
                try token = userTokenItem.readPassword()
                
            } catch {
                //Unable to read proper password from keychain, allow user to relogin
                DLog("⛔️ Token cannot be read...")
            }
            
        } else {
            DLog("⛔️ Username not found, cannot read token")
        }
        
        if token == nil {
            DLog("⛔️ Token not found")
        }
        
        return token
    }
    
    public func deleteTokenFromKeychain(username: String) {
        do {
            let userTokenItem = tokenItem(service: KeychainConfiguration.serviceName, account: username)
            try userTokenItem.deleteItem()
        } catch {
            fatalError("⛔️ deleteTokenFromKeychain: Error updating keychain - \(error)")
        }
    }
    
    fileprivate func tokenItem(service:String, account: String) -> KeychainPasswordItem {
        let userTokenItem = KeychainPasswordItem(service: service,
                                                 account: account,
                                                 accessGroup: KeychainConfiguration.accessGroup)
        return userTokenItem
    }
}



let usernameKey = "com.carryonex.user-default.key.username"

extension UserDefaults {
    //Username
    static func setUsername(_ username: String?) {
        if let username = username {
            UserDefaults.standard.set(username, forKey: usernameKey)
            UserDefaults.standard.synchronize()
        } else {
            UserDefaults.standard.removeObject(forKey: usernameKey)
        }
    }
    
    static func getUsername() -> String? {
        return UserDefaults.standard.string(forKey: usernameKey)
    }
}
