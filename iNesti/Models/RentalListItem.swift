//
//  RentalListItem.swift
//  iNesti
//
//  Created by Zian Chen on 6/9/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import Foundation

struct RentalListItem: Codable {
    let id: String
    let price: Int
    let timeUnit: Int
    let title1: String
    let title2: String
    let description: String
    let imageUrls: [String]
    
    func priceString() -> String {
        return String(format:"$%.0f", Double(price) / 100)
    }
}

struct RentalListObject: Codable {
    let statusCode: Int
    let message: String
    let results: [RentalListItem]
    let totalCount: Int
}


