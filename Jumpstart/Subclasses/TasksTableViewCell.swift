//
//  TasksTableViewCell.swift
//  Jumpstart
//
//  Created by Sean Burrows on 12/1/17.
//  Copyright © 2017 Jumpstart. All rights reserved.
//

import UIKit
import Material
import ObjectMapper

class TasksTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var taskCard: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
//    @IBOutlet weak var reminderLabel: UILabel!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var removeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleCellContents()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

    
    //MARK: Styling
    private func styleCellContents(scale: Bool = true) {
        
        //deadlineLabel
        deadlineLabel.textColor = .jRed
        
        //progressSlider
        progressSlider.minimumTrackTintColor = .jGreen //track color
        progressSlider.isContinuous = false //update on release
        
        //card
        taskCard.layer.masksToBounds = false
        taskCard.layer.shadowColor = UIColor.lightGray.cgColor
        taskCard.layer.shadowOpacity = 0.1
        taskCard.layer.shadowOffset = CGSize(width: -1, height: 0.1)
        taskCard.layer.shadowRadius = 0.001
        
        taskCard.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        taskCard.layer.shouldRasterize = true
        taskCard.layer.rasterizationScale = scale ? UIScreen.main.scale : 0.0001
    }
}
