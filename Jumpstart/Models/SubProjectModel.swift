//
//  SubProjectModel.swift
//  Jumpstart
//
//  Created by Etta Godwin on 2/20/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import Foundation
import ObjectMapper

class SubProject: Mappable {
    var title: String?
    var deadline: Date?
    var progress: Int?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        deadline <- map["deadline"]
        progress <- map["progress"]
    }
    
}
