//
//  NetworkHelper.swift
//  CryptoProject
//
//  Created by Tran Gia Huy on 2/26/18.
//  Copyright © 2018 HUDU. All rights reserved.
//

import Alamofire
import SwiftyJSON

class NetworkHelper {
    
    static let sharedInstance = NetworkHelper ()
    private let reachabilityManager = NetworkReachabilityManager()
    var isConnect: Bool? {
        return NetworkReachabilityManager()?.isReachable
    }
    
    private init() {}
    
    func connectingChange(_ connected: @escaping (Bool) -> ()) {
        reachabilityManager?.listener = { status in
            if (status != .unknown && status != .notReachable) {
                connected(true)
            }else {
                connected(false)
            }
            self.reachabilityManager?.startListening()
        }
    }
    
    
    func get(url: String, complete:((_ success: JSON?,_ error: Error?)->())?) {
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            self.respone(result: response.result, complete: complete)
        }
    }
    
    func post(url: String, params: Dictionary<String, Any>, complete:((_ success: JSON?,_ error: Error?)->())?) {
        Alamofire.request(url, method: .post, parameters: params).validate().responseJSON { response in
            self.respone(result: response.result, complete: complete)
        }
    }
    
    func respone(result: Result<Any>, complete: ((_ success: JSON?,_ error: Error?)->())?) {
        switch result {
        case .success(let value):
            let json = JSON(value)
            if let complete = complete {
                complete(json, nil)
            }
        case .failure(let error):
            if let complete = complete {
                complete(nil, error)
            }
        }
    }
    

}
