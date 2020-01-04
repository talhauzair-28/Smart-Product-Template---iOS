//
//  ApiCall.swift
//  Smart Product Template
//
//  Created by Talha Uzair on 02/01/2020.
//  Copyright © 2020 Talha Uzair. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APICalls{
    
    
    private static let timeOutInterval = 10.0
    private static let timeOutIntervalForNoInternet = 1.5
    
    static func post(URL: String, parameters: Parameters?, token: String? = nil ,header: HTTPHeaders? = nil, callBack: ((DataResponse<Any>) -> Void)?){
        var headers: HTTPHeaders?
        if(header == nil && token != nil){
            print("POST TOKEN VALUE: \(token!)")
            headers = [
                "Authorization": "Bearer \(token!)",
                "Accept": "application/json"
            ]
        }
        else{
            headers = header
        }
        let manager = Alamofire.SessionManager.default
        if (!Reachability.isConnectedToNetwork()){
            // internet not available
            manager.session.configuration.timeoutIntervalForRequest = timeOutIntervalForNoInternet
        }
        else{
            manager.session.configuration.timeoutIntervalForRequest = timeOutInterval
        }
        manager.request(URL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                if callBack != nil{
                    callBack!(response)
                }
        }
    }
    
    static func get(URL: String, parameters: Parameters?, token: String, callBack: ((DataResponse<Any>) -> Void)?){
        print("GET TOKEN VALUE: \(token)")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        let manager = Alamofire.SessionManager.default
        if (!Reachability.isConnectedToNetwork()){
            // internet not available
            manager.session.configuration.timeoutIntervalForRequest = timeOutIntervalForNoInternet
        }
        else{
            manager.session.configuration.timeoutIntervalForRequest = timeOutInterval
        }
        print("timeout: \(manager.session.configuration.timeoutIntervalForRequest)")
        
        // manager.request(URL, method: .get, parameters: parameters, encoding: URLEncoding(destination: .queryString),
        manager.request(URL, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if callBack != nil{
                callBack!(response)
            }
        }
    }
}
