//
//  TaskViewModel.swift
//  Jumpstart
//
//  Created by Etta Godwin on 5/3/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class TaskViewModel: NSObject {
    
    var subProject: SubProject!
    var task: Task!
    var user: UserModel!
    
    func getTasks(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        getTasksCall(completionHandler: completionHandler)
    }
    
    private func getTasksCall(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        let JSONString  = Mapper().toJSONString(subProject, prettyPrint: true)
        let parameters = convertToJSON(text: JSONString!)
        Alamofire.request("https://us-central1-jumpstart-f48ac.cloudfunctions.net/getsubprojectbyid2", method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                completionHandler(value as? [String:Any], nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
            
        }
    }
    
    
    func createTask(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        createTaskCall(completionHandler: completionHandler)
    }
    
    private func createTaskCall(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        let JSONString  = Mapper().toJSONString(task, prettyPrint: true)
        let parameters = convertToJSON(text: JSONString!)
        print (parameters)
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
    
    func getAllTasks(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        getAllTasksCall(completionHandler: completionHandler)
    }
    
    private func getAllTasksCall(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        let JSONString  = Mapper().toJSONString(user, prettyPrint: true)
        let parameters = convertToJSON(text: JSONString!)
 
        Alamofire.request("https://us-central1-jumpstart-f48ac.cloudfunctions.net/getglobaltasks", method: .post, parameters: parameters, headers: nil).responseJSON { response in
            switch response.result {
            case .success(let value):
                completionHandler(value as? [String:Any], nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}

