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

enum RentalDuration {
    case day, month, year
}
