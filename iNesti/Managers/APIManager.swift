//
//  APIManager.swift
//  iNesti
//
//  Created by Zian Chen on 5/20/18.
//  Copyright © 2018 iShareLLC. All rights reserved.
//

import UIKit
import Alamofire

class APIManager: NSObject {
    
    static let shared = APIManager()
    
    enum ServerRoute: String {
        case rentalDetail = "rental/detail"
        case rentalSearch = "rental/search"
        case rentalList = "rental/list"
    }
    
    enum ServerKey: String {
        case data = "data"
        case appToken = "app_token"
        case statusCode = "status_code"
        case message = "message"
    }
    
    let host = "https://8iw95ock4b.execute-api.us-east-1.amazonaws.com/prod/"
    
    func getRentalDetail(city: String, neighborhood: String, title: String, postTime: Int) {
        
        let params: [String: Any] = [
            "city" : city,
            "neighborhood": neighborhood,
            "title": title,
            "postTime": postTime
        ]
        
        getDataReturn(route: ServerRoute.rentalDetail.rawValue, params: params) { (data, error) in
            print(data)
        }
    }
    
    func getRentalSearch(rentalType: String, start: Int, limit: Int, duration: Int, neighborhood: String, startDate: Int, durationUnit: Int, minPrice: Int, maxPrice: Int) {
        
        let params: [String: Any] = [
            "rentalType" : rentalType,
            "start": start,
            "limit": limit,
            "duration": duration,
            "neighborhood": neighborhood,
            "startDate": startDate,
            "durationUnit": durationUnit,
            "minPrice": minPrice,
            "minPrice": minPrice
        ]
        
        getDataReturn(route: ServerRoute.rentalList.rawValue, params: params) { (data, error) in
            print(data)
        }
    }
    
    func getRentalList(city: String, start: Int, limit: Int, completion: @escaping((RentalResponse?, Error?) -> Void)) {
        
        let params: [String: Any] = [
            "city" : city,
            "start": start,
            "limit": limit
        ]
        
        getDataReturn(route: ServerRoute.rentalList.rawValue, params: params) { (data, error) in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(RentalResponse.self, from: data)
                    completion(response, nil)
                } catch {
                    DLog("JSON failed: \(error)")
                    completion(nil, error)
                }
            }
        }
    }
    
    //MARK: POST DATA HANDLERS
    
    func postBooleanReturn(route: String, data: [String: Any], completion: @escaping (Bool, Error?) -> Void) {
        
        let parameters: [String: Any] = [
            //ServerKey.appToken.rawValue : appToken,
            //ServerKey.timestamp.rawValue: Date.getTimestampNow(),
            ServerKey.data.rawValue: data
        ]
        
        /*
        if withAuth {
            guard let profileUser = ProfileManager.shared.getCurrentUser() else {
                DLog("[ERROR] \(route): [postBooleanReturn] Unable to find profile user")
                completion(false, nil)
                return
            }
            parameters[ServerKey.userToken.rawValue] = profileUser.token ?? ""
            parameters[ServerKey.username.rawValue] = profileUser.username ?? ""
        }
         */
        
        postDataWithUrlRoute(route, parameters: parameters) { (response, error) in
            guard let response = response else {
                if let error = error {
                    DLog("\(route) update response error: \(error.localizedDescription)")
                }
                completion(false, error)
                return
            }
            
            if let status = response[ServerKey.statusCode.rawValue] as? Int, status == 200 {
                DLog("[SUCCESS] Post to \(route) Success")
                completion(true, error)
                
            } else {
                DLog("[ERROR] Unable get data from \(route)")
                completion(false, error)
            }
        }
    }
    
    func postDataReturn(route: String, params: [String: Any]?, withAuth: Bool, completion: @escaping ([String : Any]?, Int, Error?) -> Void) {
        
        var parameter: [String: Any] = [:]
            //ServerKey.appToken.rawValue : appToken,
            //ServerKey.timestamp.rawValue: Date.getTimestampNow()
        //]
        
//        if withAuth {
//            guard let profileUser = ProfileManager.shared.getCurrentUser() else {
//                DLog("\(route): Unable to find profile user")
//                completion(nil, -1, nil)
//                return
//            }
//
//            parameter[ServerKey.userToken.rawValue] = profileUser.token ?? ""
//            parameter[ServerKey.username.rawValue] = profileUser.username ?? ""
//        }
        
        //Combine the incoming data
        if let params = params {
            params.forEach { (k, v) in parameter[k] = v }
        }
        
        postDataWithUrlRoute(route, parameters: parameter) { (response, error) in
            guard let response = response else {
                if let error = error {
                    DLog("[ERROR] postDataWithUrlRoute: \(route), error: \(error.localizedDescription)")
                }
                completion(nil, -1, error)
                return
            }
            
            if let statusCode = response[ServerKey.statusCode.rawValue] as? Int {
                if let data = response[ServerKey.data.rawValue] as? [String : Any] {
                    completion(data, statusCode, nil)
                } else {
                    completion(nil, statusCode, nil)
                }
            }
        }
    }
    
    func getDataReturn(route: String, params: [String: Any]?, completion: @escaping (Data?, Error?) -> Void) {
        
        var parameter:[String: Any] = [:]
        
        //Combine the incoming data
        if let params = params {
            params.forEach { (k, v) in parameter[k] = v }
        }
        
        getDataWithUrlRoute(route, parameters: parameter) { (data, error) in
            guard let data = data else {
                if let error = error {
                    DLog("\(route) update response error: \(error.localizedDescription)")
                }
                completion(nil, error)
                return
            }
            completion(data, error)
        }
    }
    
    // MARK: - basic GET and POST by url
    /**
     * ✅ get data with url string, return NULL, try with Alamofire and callback
     */
    private func getDataWithUrlRoute(_ route: String, parameters: [String: Any], completion: @escaping((Data?, Error?) -> Void)) {
        let requestUrlStr = host + route
        let httpHeaders = ["x-api-key":"K8KvaXzfLoBivwsxGuJwaBmgaW8eCVN9UsNe0MA3"]
        
        Alamofire.request(requestUrlStr, parameters: parameters, headers:httpHeaders).response{ response in
            if let urlRequest = response.request?.url {
                let printText: String = """
                =========================
                [TIME UTC] \(Date())
                [TIME GMT] \(Date().getCurrentLocalizedDate())
                [GET ROUTE] \(route)
                [REQUEST] \(urlRequest)
                """
                DLog(printText)
            }
            
            if let data = response.data {
                completion(data, nil)
//                do {
//                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    DLog("JSON success: \(jsonObject)")
//                } catch {
//                    DLog("JSON failed: \(error.localizedDescription)")
//                }
            } else {
                completion(nil, response.error)
            }
        }
    }
    
    /**
     * ✅ POST data with url string, using Alamofire
     */
    private func postDataWithUrlRoute(_ route: String, parameters: [String: Any], completion: @escaping(([String : Any]?, Error?) -> Void)) {
        
        let requestUrlStr = host + route
        
        Alamofire.request(requestUrlStr, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { (response) in
            
            if let requestBody = response.request?.httpBody, let body = NSString(data: requestBody, encoding: String.Encoding.utf8.rawValue) {
                let printText: String = """
                =========================
                [TIME UTC] \(Date())
                [TIME GMT] \(Date().getCurrentLocalizedDate())
                [POST ROUTE] \(route)
                [PARAMETERS] \(parameters)
                [BODY] \(body)
                """
                DLog(printText)
            }
            
            if let responseValue = response.value?.toJSON() as? [String: Any] {
                
                if let statusCode = responseValue[ServerKey.statusCode.rawValue] as? Int, statusCode != 200 {
                    let message = responseValue[ServerKey.message.rawValue] ?? ""
                    let printText: String = """
                    =========================
                    [STATUS_CODE] \(statusCode)
                    [MESSAGE]: \(message)
                    """
                    DLog(printText)
                    
                    //self.handleAbnormalStatusCode(statusCode)
                }
                completion(responseValue, nil)
                
            } else {
                DLog("[POST_ERROR] raw data = \(response.data?.description ?? "NULL")")
                
                if let data = response.data {
                    let decodedData = String.init(data: data, encoding: String.Encoding.utf8)
                    DLog("[POST_ERROR] data decoded = \(decodedData ?? "NULL")")
                }
                DLog("[POST_ERROR] description value = \(response.description)")
                DLog("[POST_ERROR] error value = \(response.error?.localizedDescription ?? "NULL")")
                DLog("[FULL RESPONSE] = \(response.value ?? "NULL")")
                completion(nil, response.result.error)
            }
        }
    }
}
