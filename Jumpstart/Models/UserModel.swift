//
//  UserModel.swift
//  Jumpstart
//
//  Created by Gabriel I Leyva Merino on 3/28/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import ObjectMapper

class UserModel: Mappable {
var firstName: String?
var lastName: String?
var uid: String?
var email: String?

required init?(map: Map) {
    
}

required init?() {
    
}

func mapping(map: Map) {
    firstName <- map["firstName"]
    lastName <- map["lastName"]
    uid <- map["uid"]
    email <- map["email"]
 }
}
