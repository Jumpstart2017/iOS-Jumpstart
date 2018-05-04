//
//  TaskViewModel.swift
//  Jumpstart
//
//  Created by Sean Burrows on 5/3/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import Alamofire
import ObjectMapper

class TaskViewModel: NSObject {
    
    var task: Task!
    var user: UserModel!
    
    func getAllTasks(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        let JSONString  = Mapper().toJSONString(user, prettyPrint: true)
        let parameters = convertToJSON(text: JSONString!)
        
        Alamofire.request("https://us-central1-jumpstart-f48ac.cloudfunctions.net/getglobaltasks", method: .get, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                completionHandler(value as? [String:Any], nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
            
        }
    }
    
    func createTask(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        let JSONString  = Mapper().toJSONString(task, prettyPrint: true)
        let parameters = convertToJSON(text: JSONString!)
        
        Alamofire.request("https://us-central1-jumpstart-f48ac.cloudfunctions.net/createTask", method: .post, parameters: parameters, headers: nil).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
                completionHandler(value as? [String:Any], nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    func deleteTask() {
        
    }
}
