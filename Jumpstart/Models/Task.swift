//
//  Task.swift
//  Jumpstart
//
//  Created by Sean Burrows on 11/30/17.
//  Copyright © 2017 Jumpstart. All rights reserved.
//

import Foundation
import ObjectMapper

class Task: Mappable {
    var completed: Bool?
    var deadline: String?
    var description: String?
    var progress: Int?
    var reminder: Int?
    var tid: String?
    var uid: String?
    var pid: String?
    var spid: String?
    
    required init?(map: Map){}
    required init?(){}
    
    func mapping(map: Map) {
        completed <- map["completed"]
        description <- map["description"]
        deadline <- map["deadline"]
        progress <- map["progress"]
        reminder <- map["reminder"]
        pid <- map["project"]
        tid <- map["tid"]
        spid <- map["spid"]
        uid <- map["uid"]
    }
}
