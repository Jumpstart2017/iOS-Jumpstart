//
//  TasksTableViewCell.swift
//  Jumpstart
//
//  Created by Sean Burrows on 12/1/17.
//  Copyright © 2017 Jumpstart. All rights reserved.
//

import UIKit
import Material

class TasksTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var taskCard: UIView!
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
    
    //MARK: Actions
    @IBAction func updateProgress(_ sender: UISlider) {
        //if progress slider complete, need to hide task
        //update the value of the task 
    }
    
    @IBAction func deleteTask(_ sender: Any) {
        //if the sender is the progress slider
    }
    
    //MARK: Styling
    private func styleCellContents() {
        //descriptionLabel
        
        //deadlineLabel
        deadlineLabel.textColor = .jRed
        
        //reminderLabel
        
        //progressSlider
        progressSlider.minimumTrackTintColor = .jGreen
        progressSlider.isContinuous = false
        
        //removeButton
        
        //card
        taskCard.backgroundColor = UIColor.white
        contentView.backgroundColor = Color.grey.lighten5
        taskCard.layer.cornerRadius = 2.0
        taskCard.layer.masksToBounds = false
        taskCard.layer.shadowColor = Color.black.cgColor
        taskCard.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        taskCard.layer.shadowOpacity = 0.8
    }
}
