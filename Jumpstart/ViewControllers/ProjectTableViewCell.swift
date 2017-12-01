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
        progressCard.layer.cornerRadius = 2.0
        progressCard.layer.masksToBounds = false
        progressCard.layer.shadowColor = Color.black.cgColor
        progressCard.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        progressCard.layer.shadowOpacity = 0.8
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
