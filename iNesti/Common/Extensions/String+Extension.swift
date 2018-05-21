//
//  String+Extensions.swift
//  iNesti
//
//  Created by Zian Chen on 5/20/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import Foundation

extension String {
    func quickTossPassword() -> String {
        return String(self.reversed()) + inestSalt
    }
    
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                DLog(error.localizedDescription)
            }
        }
        return nil
    }
    
//    func md5() -> String {
//        let str = self.cString(using: String.Encoding.utf8)
//        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLength = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLength)
//        
//        CC_MD5(str, strLen, result)
//        
//        let hash = NSMutableString()
//        
//        for i in 0..<digestLength {
//            hash.appendFormat("%02x", result[i])
//        }
//        
//        result.deinitialize()
//        
//        return String(format: hash as String)
//    }
    
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
