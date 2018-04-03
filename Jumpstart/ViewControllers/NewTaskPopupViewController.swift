//
//  NewTaskPopupViewController.swift
//  Jumpstart
//
//  Created by Sean Burrows on 2/13/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import UIKit

class NewTaskPopup: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var popupview: UIView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var newTaskLabel: UILabel!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var reminderSelect: UISegmentedControl!
    @IBOutlet weak var projectSelectText: UITextField!
    @IBOutlet weak var deadlineText: UITextField!
    
    var projectList = [String]()
    let deadlinePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deadlinePicker.datePickerMode = UIDatePickerMode.date
        deadlinePicker.addTarget(self, action: #selector(NewTaskPopup.deadlinePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        prepareView()
        preparePopup()
        prepareDescriptionTextField()
        prepareExitButton()
        prepareNewTaskLabel()
        prepareCreateButton()
        prepareReminderSelect()
        prepareProjectSelectText()
        prepareDeadlineText()
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        projectSelectText.text = projectList[row]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func deadlinePickerValueChanged(sender: UIDatePicker) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MMM dd, yyyy"
        let dateStr = dateformatter.string(from: sender.date)
        deadlineText.text = dateStr
    }
    
    @IBAction func exitPopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension NewTaskPopup {
    
    fileprivate func preparePopup() {
        popupview.layer.shadowOpacity = 0.5 //show shadow
        popupview.layer.shadowOffset = CGSize(width: 6, height: 6) //left and bottom only
        popupview.layer.shadowRadius = 0.0 //sharp corners
        popupview.layer.shadowColor = UIColor.lightGray.cgColor
        
        popupview.layer.borderWidth = 1
        popupview.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    fileprivate func prepareDescriptionTextField() {
        descriptionTextField.placeholder = "Description"
        descriptionTextField.borderStyle = UITextBorderStyle.roundedRect
        descriptionTextField.layer.borderWidth = 0
        descriptionTextField.layer.borderColor = UIColor.red.cgColor
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
        (reminderSelect.subviews[2] as UIView).tintColor = .jRed
        (reminderSelect.subviews[1] as UIView).tintColor = .jYellow
        (reminderSelect.subviews[0] as UIView).tintColor = .jBlue
    }
    
    fileprivate func prepareView() {
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
    
    fileprivate func prepareDeadlineText() {
        deadlineText.placeholder = "Deadline"
        deadlineText.inputView = deadlinePicker
        deadlineText.borderStyle = UITextBorderStyle.roundedRect
        deadlineText.layer.borderWidth = 0
        deadlineText.layer.borderColor = UIColor.red.cgColor
    }
    
    fileprivate func prepareProjectSelectText() {
        // Load projects into projectList
        projectList = [
            "Big Book of Nothing",
            "Dissertation",
            "Master's Thesis",
            "Research Paper",
            "Embedded Systems Presentation",
            "Definitive Objective Analysis of 'Workaholics'"
        ]
        
        projectSelectText.placeholder = "Project"
        let projectPicker = UIPickerView()
        projectPicker.delegate = self
        projectSelectText.inputView = projectPicker
        
        projectSelectText.borderStyle = UITextBorderStyle.roundedRect
        projectSelectText.layer.borderWidth = 0
        projectSelectText.layer.borderColor = UIColor.red.cgColor
    }
    
    // MARK: Actions
    @IBAction func createTask(_ sender: Any) {
        let hasDeadline = deadlineText.text != ""
        let hasProject = projectSelectText.text != ""
        let hasDescription = descriptionTextField.text != ""
        
        if(!hasDeadline) {
            deadlineText.layer.borderWidth = 1
        }
        else {
            deadlineText.layer.borderWidth = 0
        }
        
        if(!hasDescription) {
            descriptionTextField.layer.borderWidth = 1
        }
        else {
            descriptionTextField.layer.borderWidth = 0
        }
        
        if(!hasProject) {
            projectSelectText.layer.borderWidth = 1
        }
        else {
            projectSelectText.layer.borderWidth = 0
        }
        
        if(hasProject && hasDescription && hasDeadline) {
            let parameters = [
                "completed": false,
                "deadline": deadlineText.text,
                "description": descriptionTextField.text,
                "progress": 0,
                "reminder": reminderSelect.selectedSegmentIndex,
                "project": projectSelectText.text
            ] as [String: Any]
        
            print(parameters)
        }
    }
}
