//
//  NewUser.swift
//  Jumpstart
//
//  Created by Gabriel I Leyva Merino on 12/1/17.
//  Copyright © 2017 Jumpstart. All rights reserved.
//

import Foundation
import ObjectMapper

class NewUser: Mappable {
    var firstName: String?
    var lastName: String?
    var password: String?
    var email: String?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        password <- map["password"]
        email <- map["email"]
    }
    
}
