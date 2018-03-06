//
//  NewProjectViewModel.swift
//  Jumpstart
//
//  Created by Etta Godwin on 2/20/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import Foundation
import Alamofire

class NewProjectViewModel: NSObject {
    
    var project: Project!
    
    
    func createProject(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        createProjectCall(completionHandler: completionHandler)
    }
    
    private func createProjectCall(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        let parameters : Parameters = ["scanType": "Complete"]
        
        Alamofire.request("https://us-central1-jumpstart-f48ac.cloudfunctions.net/createProject", method: .post, parameters: parameters, headers: nil).responseJSON { response in
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
