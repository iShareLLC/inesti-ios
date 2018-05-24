//
//  RentalDataStore.swift
//  iNesti
//
//  Created by Zian Chen on 5/23/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit

class RentalDataStore: NSObject {
    
    static let shared = RentalDataStore()
    
    private var publishedRental: [Rental] = [Rental]()
    private var unpublishRental: [Rental] = [Rental]()
    
    func addRental(rental: Rental, state: RentalPublishState) {
        if (state == .published) {
            publishedRental.append(rental)
        } else {
            unpublishRental.append(rental)
        }
        //TODO: API ADD
    }
    
    func removeRental(id: Int, state: RentalPublishState) {
        let targetRentals = (state == .published) ? publishedRental : unpublishRental
        if let index = targetRentals.index(where: {$0.id == id}) {
            if (state == .published) {
                publishedRental.remove(at: index)
            } else {
                unpublishRental.remove(at: index)
            }
        }
        
        //TODO: API REMOVE
    }
    
    func getRentals(state: RentalPublishState) -> [Rental] {
        return (state == .published) ? publishedRental : unpublishRental
    }
}

enum RentalPublishState {
    case published, unpublish
}
