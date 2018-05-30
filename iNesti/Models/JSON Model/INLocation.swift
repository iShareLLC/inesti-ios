//
//  INLocation.swift
//  iNesti
//
//  Created by Zian Chen on 5/30/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import Foundation

struct INLocation: Decodable {
    let location: String
    let displayName: String
    
    enum CodingKeys: String, CodingKey {
        case location
        case displayName
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        location = try values.decode(String.self, forKey: .location)
        displayName = try values.decode(String.self, forKey: .displayName)
    }
}
