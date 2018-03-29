//
//  UserViewModel.swift
//  Jumpstart
//
//  Created by Gabriel I Leyva Merino on 3/28/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import Foundation

import Alamofire
import ObjectMapper

class UserViewModel: NSObject {
    
    func getUser(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        getUserCall(completionHandler: completionHandler)
    }
    
    private func getUserCall(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        
        Alamofire.request("https://us-central1-jumpstart-f48ac.cloudfunctions.net/getuser", method: .get, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                completionHandler(value as? [String:Any], nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
            
        }
    }
    
}
