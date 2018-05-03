//
//  ProjectFakeData.swift
//  Jumpstart
//
//  Created by Etta Godwin on 2/15/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import Foundation
import UIKit

func makeProjectModels() -> [Project] {
    var myObjects = [Project]()
    var mySubProject = [SubProject]()
    
    let sp = SubProject()
    sp?.title = "Chapter 1"
    sp?.deadline = "11/6/18"
    sp?.progress = 23
    mySubProject.append(sp!)
    
    for _ in 0 ... 5 {
        let obj = Project()
        obj?.title = "Paper"
        obj?.deadline = "11/7/18"
        obj?.progress = 65
        obj?.type = 1
        obj?.subprojects = mySubProject
        myObjects.append(obj!)
       
    }
    
    return myObjects
}
