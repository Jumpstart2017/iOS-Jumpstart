//
//  VideoViewModel.swift
//  Jumpstart
//
//  Created by Gabriel I Leyva Merino on 3/1/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class VideoViewModel: NSObject {
    
    var user: NewUser!
    
    func getVideos(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
        getVideosCall(completionHandler: completionHandler)
    }
    
    private func getVideosCall(completionHandler: @escaping ([String:Any]?, Error?) -> ()) {
 
        Alamofire.request("https://us-central1-jumpstart-f48ac.cloudfunctions.net/getvideos", method: .get, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                completionHandler(value as? [String:Any], nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
            
        }
    }
    
}
