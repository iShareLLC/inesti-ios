//
//  PopularPlacesAPI.swift
//  iNesti
//
//  Created by Cunqi Xiao on 4/17/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import Foundation
import Moya

enum PopularPlacesAPI {
    case popularPlaces(city: String)
}

extension PopularPlacesAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .popularPlaces(let city):
            return "https://ugbtybu1el.execute-api.us-east-1.amazonaws.com/prod/popular-places?city=\(city)".webURL!
        }
    }

    var path: String {
        return ""
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String : String]? {
        return nil
    }
}
