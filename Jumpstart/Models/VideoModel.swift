//
//  VideoModel.swift
//  Jumpstart
//
//  Created by Gabriel I Leyva Merino on 11/28/17.
//  Copyright © 2017 Jumpstart. All rights reserved.
//


import ObjectMapper

class VideoModel: Mappable {
    var vid: String?
    var title: String?
    var description: String?
    var url: String?
    var html: String?
    
    required init?(map: Map) {
        
    }
    
    required init?() {
        
    }
    
    func mapping(map: Map) {
        vid <- map["vid"]
        title <- map["title"]
        description <- map["description"]
        url <- map["url"]
        html <- map["html"]
    }
    
}
