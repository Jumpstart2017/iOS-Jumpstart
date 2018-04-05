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
        if(progressSlider.value == 1) {
        }
    }
    
    @IBAction func deleteTask(_ sender: Any) {
        //if the sender is the progress slider
    }

    
    //MARK: Styling
    private func styleCellContents() {
        
        //deadlineLabel
        deadlineLabel.textColor = .jRed
        
        //progressSlider
        progressSlider.minimumTrackTintColor = .jGreen //track color
        progressSlider.isContinuous = false //update on release
        
        //card
        taskCard.layer.shadowOpacity = 0.5 //show shadow
        taskCard.layer.shadowOffset = CGSize(width: 6, height: 6) //left and bottom only
        taskCard.layer.shadowRadius = 0 //sharp corners
        taskCard.layer.shadowColor = UIColor.lightGray.cgColor
    }
}
