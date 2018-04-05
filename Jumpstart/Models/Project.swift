//
//  Project.swift
//  Jumpstart
//
//  Created by Etta Godwin on 11/28/17.
//  Copyright © 2017 Jumpstart. All rights reserved.
//

import Foundation
import ObjectMapper

class Project: Mappable {
    var title: String?
    //var deadline: Date?
    var deadline: String?
    var progress: Int?
    var type: Int?
    var wordCount: Int?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        deadline <- map["deadline"]
        progress <- map["progress"]
        type <- map["type"]
        wordCount <- map["wordCount"]
    }
    
}
