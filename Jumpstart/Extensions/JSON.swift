//
//  JSON.swift
//  Jumpstart
//
//  Created by Gabriel I Leyva Merino on 2/13/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

func convertToJSON(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print("In JSON")
            print(error.localizedDescription)
        }
    }
    return nil
}
