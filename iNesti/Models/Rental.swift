//
//  Rental.swift
//  iNesti
//
//  Created by Zian Chen on 5/23/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

struct Rental {
    let id: Int
}

struct RentalFinal {
    let id: Int
    let imageUrls: [String]?
    let availableStartDate: Int
    let availableEndDate: Int
    let title: String
    let description: String
    let prices: [String: [Int]]?
    let includeInternet: Bool
    let includeElectricity: Bool
    let includeWater: Bool
    let includeGas: Bool
    let allowCat: Bool
    let allowDog: Bool
    let noSmoking: Bool
    let hasDoorman: Bool
    let hasWasher: Bool
    let hasDryer: Bool
    let highlights: [String]
    let transportation: [String]
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
