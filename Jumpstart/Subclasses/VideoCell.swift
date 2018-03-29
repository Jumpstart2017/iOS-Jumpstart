//
//  VideoCell.swift
//  Jumpstart
//
//  Created by Gabriel I Leyva Merino on 11/28/17.
//  Copyright © 2017 Jumpstart. All rights reserved.
//

import Foundation
import UIKit

class VideoCell: UITableViewCell {
    
    var videoCardView: VideoCard?
    
    override func awakeFromNib() {
        
    }
    
    func initVideoCellWith(videoModel: VideoModel) {
         videoCardView = VideoCard()
        self.dropShadow()
        videoCardView!.initVideoCardWith(url: videoModel.url!, title: videoModel.title!, description: videoModel.description!, embedHTML: videoModel.html!)
        self.layout(videoCardView!).horizontally(left: 10, right: 10).center()
        self.dropShadow()
        
    }
    
    func dropShadow(scale: Bool = true) {
    
        videoCardView!.layer.masksToBounds = false
        videoCardView!.layer.shadowColor = UIColor.lightGray.cgColor
        videoCardView!.layer.shadowOpacity = 0.1
        videoCardView!.layer.shadowOffset = CGSize(width: -1, height: 0.1)
        videoCardView!.layer.shadowRadius = 0.001
        
        videoCardView!.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        videoCardView!.layer.shouldRasterize = true
        videoCardView!.layer.rasterizationScale = scale ? UIScreen.main.scale : 0.0001
    }
    
   override func prepareForReuse() {
        self.videoCardView = nil
    }

}
