//
//  TasksTableViewCell.swift
//  Jumpstart
//
//  Created by Sean Burrows on 12/1/17.
//  Copyright © 2017 Jumpstart. All rights reserved.
//

import UIKit

class TasksTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var reminderLabel: UILabel!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var removeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        styleCellContents()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func styleCellContents() {
        //descriptionLabel
        
        //deadlineLabel
        deadlineLabel.textColor = .jRed
        
        //reminderLabel
        
        //progressSlider
        progressSlider.minimumTrackTintColor = .jGreen
        progressSlider.isContinuous = false 
        
        //removeButton
    }
}
