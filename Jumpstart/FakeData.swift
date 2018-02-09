//
//  FakeData.swift
//  Jumpstart
//
//  Created by Gabriel I Leyva Merino on 11/28/17.
//  Copyright © 2017 Jumpstart. All rights reserved.
//

import Foundation
import UIKit

func makeVideoModels() -> [VideoModel] {
    var myObjects = [VideoModel]()
    
    
    for _ in 0 ... 5 {
        let obj = VideoModel()
        obj?.title = "Engaging Sources"
        obj?.description = "Learn about your sources"
        obj?.url = "https://vimeo.com/114695683"
        obj?.html = "<iframe src= \"https://player.vimeo.com/video/114695683\" width= \"340\" height= \"200\" frameborder= \"0\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
        myObjects.append(obj!)
        
    }
    
    return myObjects
}



struct Section {
    var name: String
    var items: [VideoModel]
    var collapsed: Bool
    
    init(name: String, items: [VideoModel], collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

var sections = [
    Section(name: "Research", items: makeVideoModels()),
    Section(name: "Writing", items: makeVideoModels()),
    Section(name: "Revision", items: makeVideoModels())
]



