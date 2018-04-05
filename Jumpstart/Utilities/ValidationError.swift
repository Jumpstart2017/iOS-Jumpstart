//
//  ValidationError.swift
//  Jumpstart
//
//  Created by Gabriel I Leyva Merino on 3/28/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import Foundation
struct ValidationError: Error {
    
    public let message: String
    
    public init(message m: String) {
        message = m
    }
}
