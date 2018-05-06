//
//  LocationInputViewModel.swift
//  iNesti
//
//  Created by Cunqi Xiao on 5/2/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import Foundation
import RxSwift

class LocationInputViewModel {
    let userInputedText = Variable<String?>(nil)
    let providedLocations = Variable<[String]>([])

    let  dataSource: Observable<[String]>

    init() {
        dataSource = Observable.combineLatest(userInputedText.asObservable(), providedLocations.asObservable())
            .map { input, locations in
                guard let mInput = input else {
                    return ["当前位置"]
                }
                return locations.filter{ $0.contains(mInput) }
            }
            .asObservable()
    }
}
