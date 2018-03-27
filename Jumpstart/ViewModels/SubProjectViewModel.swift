//
//  NewSubProjectViewModel.swift
//  Jumpstart
//
//  Created by Etta Godwin on 3/6/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import Foundation
//
//  ProjectViewModel.swift
//  Jumpstart
//
//  Created by Etta Godwin on 3/27/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class SubProjectViewModel: NSObject {
    
    var subProject: SubProject!
    

    func createSubProject(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        createSubProjectCall(completionHandler: completionHandler)
    }
    
    private func createSubProjectCall(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        let JSONString  = Mapper().toJSONString(subProject, prettyPrint: true)
        let parameters = convertToJSON(text: JSONString!)
        
        Alamofire.request("https://us-central1-jumpstart-f48ac.cloudfunctions.net/createSubproject", method: .post, parameters: parameters, headers: nil).responseJSON { response in
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

