//
//  RegisterViewModel.swift
//  Jumpstart
//
//  Created by Gabriel I Leyva Merino on 1/25/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class RegisterViewModel: NSObject {
    
    var user: NewUser!
    
    
    func registerUser(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        registerUserCall(completionHandler: completionHandler)
    }
    
    private func registerUserCall(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        let JSONString  = Mapper().toJSONString(user, prettyPrint: true)
        let parameters = convertToJSON(text: JSONString!)
        
        Alamofire.request("https://us-central1-jumpstart-f48ac.cloudfunctions.net/register", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
                completionHandler(value as? [String:Any], nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
            
        }
    }
    
}
