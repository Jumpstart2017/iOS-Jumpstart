//
//  NewTaskPopupViewController.swift
//  Jumpstart
//
//  Created by Sean Burrows on 2/13/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import UIKit

class NewTaskPopup: UIViewController {
    @IBOutlet weak var popupview: UIView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var newTaskLabel: UILabel!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var reminderSelect: UISegmentedControl!
    @IBOutlet weak var deadlinePicker: UIDatePicker!
    @IBOutlet weak var projectPicker: UIPickerView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preparePopup()
        prepareDescriptionTextField()
        prepareExitButton()
        prepareNewTaskLabel()
        prepareCreateButton()
        prepareReminderSelect()
        prepareDeadline()
        prepareDeadlineLabel()
        prepareProjectSelect()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension NewTaskPopup {
    
    fileprivate func preparePopup() {
        popupview.layer.shadowOpacity = 0.5 //show shadow
        popupview.layer.shadowOffset = CGSize(width: 6, height: 6) //left and bottom only
        popupview.layer.shadowRadius = 0 //sharp corners
        popupview.layer.shadowColor = UIColor.lightGray.cgColor
    }
    
    fileprivate func prepareDescriptionTextField() {
        descriptionTextField.placeholder = "Description"
    }
    
    fileprivate func prepareExitButton() {
        exitButton.titleLabel?.text = "X"
        exitButton.titleLabel?.textColor = .jRed
    }
    
    fileprivate func prepareNewTaskLabel() {
        newTaskLabel.text = "New Task"
        newTaskLabel.textColor = UIColor.darkGray
    }
    
    fileprivate func prepareCreateButton() {
        createButton.titleLabel?.text = "Create"
        createButton.titleLabel?.backgroundColor = .jGreen
        createButton.tintColor = .white
    }
    
    fileprivate func prepareReminderSelect() {
        //titles
        reminderSelect.setTitle("Monthly", forSegmentAt: 0)
        reminderSelect.setTitle ("Weekly", forSegmentAt: 1)
        reminderSelect.insertSegment(withTitle: "Daily", at: 2, animated: true)
        
        //colors
    }
    
    fileprivate func prepareDeadline() {
        
    }
    
    fileprivate func prepareDeadlineLabel() {
        deadlineLabel.text = "Deadline"
    }
    
    fileprivate func prepareProjectSelect() {
        
    }
}
