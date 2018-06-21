//
//  Rental.swift
//  iNesti
//
//  Created by Zian Chen on 5/23/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

struct Rental: Codable {
    let id: Int?
    let imageUrls: [String]?
    let availableStartDate: Int
    let availableEndDate: Int
    let title: String
    let description: String
    let prices: RentalPrices
    let basicFeatures: [String]
    let highlights: [String]
    let moreHighlights: [String]
    let transportations: RentalTransportation
}

struct RentalPrices: Codable {
    let entireUnit: RentalUnit?
    let masterRoom: RentalUnit?
}

struct RentalUnit: Codable {
    let currency: String
    let month: Int
    let week: Int
    let day: Int
}

struct RentalTransportation: Codable {
    let subway: RentalTransportationInfo
    let path: RentalTransportationInfo
}

struct RentalTransportationInfo: Codable {
    let zhHans: RentalTransportationLanguage
    let en: RentalTransportationLanguage
}

struct RentalTransportationLanguage: Codable {
    let startText: String
    let endText: String
}

public enum RentalDuration: Int {
    case month = 0
    case day = 1
    case week = 2
    
    static func duration(value: Int) -> RentalDuration {
        switch value {
        case 0:
            return month
        case 1:
            return day
        case 2:
            return week
        default:
            return month
        }
    }
    
    func displayString() -> String {
        switch self {
        case .month:
            return "月"
        case .day:
            return "日"
        case .week:
            return " 周"
        }
    }
}
