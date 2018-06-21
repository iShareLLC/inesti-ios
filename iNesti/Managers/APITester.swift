//
//  APITester.swift
//  iNesti
//
//  Created by Chen, Zian on 5/30/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

class APITester: NSObject {

    func testRentalDetail () {
        APIManager.shared.getRentalDetail(id: "1548976200|13", city: "nyc") { (rental, error) in
            if let rental = rental {
                print(rental.description)
            }
        }
    }
    
    func testRentalList () {
        //APIManager.shared.getRentalList(city: "nyc", start: 0, limit: 15)
    }
}
