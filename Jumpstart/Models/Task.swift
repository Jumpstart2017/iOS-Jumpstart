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
    var title: String?
    var progress: Int?
    var reminder: Int?
    var project: String?
    var spid: String?
    
    required init?(map: Map){}
    required init?(){}
    init(deadline: String,title: String,progress: Int, reminder: Int, project: String, spid: String) {
        self.deadline = deadline
        self.title = title
        self.progress = progress
        self.reminder = reminder
        self.completed = progress / 100 == 1
        self.project = project
        self.spid = spid
    }
    
    func mapping(map: Map) {
        completed <- map["completed"]
        title <- map["title"]
        deadline <- map["deadline"]
        progress <- map["progress"]
        reminder <- map["reminder"]
        project <- map["project"]
        spid <- map["spid"]
    }
}
