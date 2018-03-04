//
//  NewTaskPopupViewController.swift
//  Jumpstart
//
//  Created by Sean Burrows on 2/13/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import UIKit

class NewTaskPopup: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var popupview: UIView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var newTaskLabel: UILabel!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var reminderSelect: UISegmentedControl!
    @IBOutlet weak var deadlinePicker: UIDatePicker!
    @IBOutlet weak var projectPicker: UIPickerView!

    var projectList = [String]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        prepareView()
        preparePopup()
        prepareDescriptionTextField()
        prepareExitButton()
        prepareNewTaskLabel()
        //prepareCreateButton()
        //prepareReminderSelect()
        //prepareDeadline()
        //prepareDeadlineLabel()
        prepareProjectSelect()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return projectList.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return projectList[row]
    }
}

extension NewTaskPopup {
    
    fileprivate func preparePopup() {
        popupview.layer.shadowOpacity = 0.5 //show shadow
        popupview.layer.shadowOffset = CGSize(width: 6, height: 6) //left and bottom only
        popupview.layer.shadowRadius = 0 //sharp corners
        popupview.layer.shadowColor = UIColor.lightGray.cgColor
        
        popupview.layer.borderWidth = 1
        popupview.layer.borderColor = UIColor.black.cgColor
    }
    
    fileprivate func prepareDescriptionTextField() {
        descriptionTextField.placeholder = "Description"
    }
    
    fileprivate func prepareExitButton() {
        exitButton.setTitle("X", for: .normal)
        exitButton.setTitleColor(.jRed, for: .normal)
    }
    
    fileprivate func prepareNewTaskLabel() {
        newTaskLabel.text = "New Task"
        newTaskLabel.textColor = UIColor.darkGray
    }
    
    fileprivate func prepareCreateButton() {
        createButton.setTitle("Create", for: .normal)
        createButton.setTitleColor(UIColor.white, for: .normal)
        createButton.frame.size = CGSize(width: 100, height: 50)
        createButton.backgroundColor = .jGreen
        createButton.layer.cornerRadius = 7
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
        projectPicker.dataSource = self
        projectPicker.delegate = self
        
        // Load projects into projectList
        projectList = [
            "Big Book of Nothing",
            "Dissertation",
            "Master's Thesis",
            "Research Paper",
            "Embedded Systems Presentation",
            "Definitive Objective Analysis of 'Workaholics'"
        ]
    }
    
    fileprivate func prepareView() {
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
}
