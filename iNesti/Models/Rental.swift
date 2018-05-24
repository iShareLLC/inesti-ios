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
    let title: String
    var location: String?
    var price: Int?
    var duration: RentalDuration?
}

enum RentalDuration {
    case day, month, year
}
