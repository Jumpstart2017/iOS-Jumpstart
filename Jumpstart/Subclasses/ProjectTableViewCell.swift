//
//  ProjectTableViewCell.swift
//  Jumpstart
//
//  Created by Etta Godwin on 11/21/17.
//  Copyright © 2017 Jumpstart. All rights reserved.
//

import UIKit
import Material
import UICircularProgressRing
import ObjectMapper

class ProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var progressCard: UIView!
    @IBOutlet weak var progressTitle: UILabel!
    @IBOutlet weak var progressDeadline: UILabel!
    @IBOutlet weak var progressCircle: UICircularProgressRingView!
    
    
    override func layoutSubviews() {
        progressCard.backgroundColor = UIColor.white
        contentView.backgroundColor = Color.grey.lighten5
        dropShadow()
        prepareProgressCircle()

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func dropShadow(scale: Bool = true) {
        
        progressCard.layer.masksToBounds = false
        progressCard.layer.shadowColor = UIColor.lightGray.cgColor
        progressCard.layer.shadowOpacity = 0.1
        progressCard.layer.shadowOffset = CGSize(width: -1, height: 0.1)
        progressCard.layer.shadowRadius = 0.001
        
        progressCard.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        progressCard.layer.shouldRasterize = true
        progressCard.layer.rasterizationScale = scale ? UIScreen.main.scale : 0.0001
    }
    
    func prepareProgressCircle() {
        progressCircle.innerRingWidth = 2
        progressCircle.innerRingColor = .jGreen
        
        progressCircle.outerRingWidth = 1
        progressCircle.outerRingColor = .lightGray
                
    }

}
