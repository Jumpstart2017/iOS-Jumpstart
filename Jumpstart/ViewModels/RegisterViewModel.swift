//
//  RegisterViewModel.swift
//  Jumpstart
//
//  Created by Gabriel I Leyva Merino on 1/25/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import Foundation
import Alamofire

class RegisterViewModel: NSObject {
    
    var user: NewUser!
    
    
    func registerUser(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        registerUserCall(completionHandler: completionHandler)
    }
    
    private func registerUserCall(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        let parameters : Parameters = ["scanType": "Complete"]
        
        Alamofire.request("http://192.168.1.4/Scanner/Scan", method: .post, parameters: parameters, headers: nil).responseJSON { response in
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
