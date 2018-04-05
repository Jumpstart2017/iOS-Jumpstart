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

class ProjectViewModel: NSObject {
    
    var project: Project!
    var user: UserModel!
    
    func getProjects(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        getProjectsCall(completionHandler: completionHandler)
    }
    
    private func getProjectsCall(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        
        let JSONString  = Mapper().toJSONString(user, prettyPrint: true)
        let parameters = convertToJSON(text: JSONString!)
        
        Alamofire.request("https://us-central1-jumpstart-f48ac.cloudfunctions.net/getprojects", method: .post, parameters: parameters, headers: nil).responseJSON { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    completionHandler(value as? [String:Any], nil)
                case .failure(let error):
                completionHandler(nil, error)
                }
            
            }
        }

    
    func createProject(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        createProjectCall(completionHandler: completionHandler)
    }
    
    private func createProjectCall(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        print(self.project)
        let JSONString  = Mapper().toJSONString(project, prettyPrint: true)
        let parameters = convertToJSON(text: JSONString!)
        
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

