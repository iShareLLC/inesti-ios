//
//  HomeViewModel.swift
//  iNesti
//
//  Created by Cunqi Xiao on 4/17/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import SVProgressHUD
import RxDataSources

typealias PupularPlaceLoadingCompletedHandler = (Bool) -> Void

class HomeViewModel {
    private let api = MoyaProvider<PopularPlacesAPI>()

    let popularPlaces = Variable<[SectionOfPopularPlace]>([])

    func requestPopularPlaces(city: String = "nyc", handler: @escaping PupularPlaceLoadingCompletedHandler) {
        api.request(.popularPlaces(city: city)) { [weak self] result in
            switch result {
            case .success(let response):
                guard let success = try? response.filterSuccessfulStatusCodes() else {
                    SVProgressHUD.showError(withStatus: "common.unknownError".localized)
                    handler(false)
                    return
                }

                if let places = try? JSONDecoder().decode([PopularPlace].self, from: success.data) {
                    let sectionOfPlaces = places.map { SectionOfPopularPlace(header: "", items: [$0]) }
                    self?.popularPlaces.value = sectionOfPlaces
                    handler(true)
                    SVProgressHUD.dismiss()
                } else {
                    handler(false)
                    SVProgressHUD.showError(withStatus: "common.unknownError".localized)
                }

            case .failure(let error):
                handler(false)
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
}
