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
//
//    let nameLabel = UILabel()
//    let detailLabel = UILabel()
//
//    // MARK: Initalizers
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        let marginGuide = contentView.layoutMarginsGuide
//
//        // configure nameLabel
//        contentView.addSubview(nameLabel)
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        nameLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
//        nameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
//        nameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
//        nameLabel.numberOfLines = 0
//        nameLabel.font = UIFont.systemFont(ofSize: 16)
//
//        // configure detailLabel
//        contentView.addSubview(detailLabel)
//        detailLabel.lineBreakMode = .byWordWrapping
//        detailLabel.translatesAutoresizingMaskIntoConstraints = false
//        detailLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
//        detailLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
//        detailLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
//        detailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
//        detailLabel.numberOfLines = 0
//        detailLabel.font = UIFont.systemFont(ofSize: 12)
//        detailLabel.textColor = UIColor.lightGray
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

}
