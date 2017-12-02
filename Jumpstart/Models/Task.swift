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
    
    required init?(map: Map){}
    required init?(){}
    init(deadline: String,description: String,progress: Int, reminder: Int) {
        self.deadline = deadline
        self.description = description
        self.progress = progress
        self.reminder = reminder
        self.completed = progress / 100 == 1
    }
    
    func mapping(map: Map) {
        completed <- map["completed"]
        description <- map["description"]
        deadline <- map["deadline"]
        progress <- map["progress"]
        reminder <- map["reminder"]
    }
}
