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
    
    var videoCard: VideoCard?
    
    override func awakeFromNib() {
        
    }
    
    func initVideoCellWith(videoModel: VideoModel) {
        let videoCardView = VideoCard()
        videoCardView.initVideoCardWith(url: videoModel.url!, title: videoModel.title!, description: videoModel.description!, embedHTML: videoModel.html!)
        self.layout(videoCardView).horizontally(left: 10, right: 10).center()
        videoCardView.shadowColor = .black
        
    }

}
