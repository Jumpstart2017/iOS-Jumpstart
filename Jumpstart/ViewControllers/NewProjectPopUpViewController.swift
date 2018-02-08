//
//  NewProjectPopUpViewController.swift
//  Jumpstart
//
//  Created by Etta Godwin on 1/25/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import MaterialComponents
import Material

class NewProjectPopUpViewController: UIViewController {

    @IBOutlet weak var cancelNewProjectButton: UIButton!
    @IBOutlet weak var newProjectLabel: UILabel!
    @IBOutlet weak var createNewProjectButton: MDCRaisedButton!
    @IBOutlet weak var newProjectNameTextField: TextField!
    @IBOutlet weak var newProjectDeadlineTextField: TextField!
    @IBOutlet weak var reasearchButton: MDCFlatButton!
    @IBOutlet weak var writingButton: MDCFlatButton!
    @IBOutlet weak var revisionButton: MDCFlatButton!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.prepareButtons()
        self.prepareProjectNameTextField()
        self.prepareProjectDeadlineTextField()
        
        //newProject = Project(map: Map)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareProjectNameTextField(){
        newProjectNameTextField.placeholder = "Project Name"
        newProjectNameTextField.isClearIconButtonEnabled = true
        newProjectNameTextField.dividerActiveColor = .jBlue
        newProjectNameTextField.dividerNormalColor = .jBlue
        newProjectNameTextField.placeholderActiveColor = .jBlue
        
    }
    
    func prepareProjectDeadlineTextField(){
        newProjectDeadlineTextField.placeholder = "Deadline"
        newProjectDeadlineTextField.isClearIconButtonEnabled = true
        newProjectDeadlineTextField.dividerActiveColor = .jBlue
        newProjectDeadlineTextField.dividerNormalColor = .jBlue
        newProjectDeadlineTextField.placeholderActiveColor = .jBlue
        
        //Making Text Box have Date Picker Keyboard
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        newProjectDeadlineTextField.inputAccessoryView = toolbar
        newProjectDeadlineTextField.inputView = datePicker
        
    }
    
    //Closes Date Picker
    @objc func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        newProjectDeadlineTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func prepareButtons() {
        createNewProjectButton.backgroundColor = .jGreen
        createNewProjectButton.setTitleColor(.white, for: .normal)
        
        cancelNewProjectButton.setTitleColor(.red, for: .normal)
        
        reasearchButton.setTitleColor(.jIndependent, for: .normal)
        reasearchButton.setBorderColor(.jIndependent, for: .normal)
        reasearchButton.setBorderWidth(1.0, for: .normal)
        reasearchButton.setBackgroundColor(.jIndependent, for: .selected)
        reasearchButton.setTitleColor(.white, for: .selected)
        reasearchButton.tintColor = .clear
        reasearchButton.addTarget(self, action: #selector(buttonClicked), for: UIControlEvents.touchUpInside)

        
        writingButton.setTitleColor(.jOrange, for: .normal)
        writingButton.setBorderColor(.jOrange, for: .normal)
        writingButton.setBorderWidth(1.0, for: .normal)
        writingButton.setBackgroundColor(.jOrange, for: .selected)
        writingButton.setTitleColor(.white, for: .selected)
        writingButton.tintColor = .clear
        writingButton.addTarget(self, action: #selector(buttonClicked), for: UIControlEvents.touchUpInside)


        revisionButton.setTitleColor(.jPurple, for: .normal)
        revisionButton.setBorderColor(.jPurple, for: .normal)
        revisionButton.setBorderWidth(1.0, for: .normal)
        revisionButton.setBackgroundColor(.jPurple, for: .selected)
        revisionButton.setTitleColor(.white, for: .selected)
        revisionButton.tintColor = .clear
        revisionButton.addTarget(self, action: #selector(buttonClicked), for: UIControlEvents.touchUpInside)
    }
    
    //For Selecting/Deselecting Buttons
    @objc func buttonClicked(sender:MDCFlatButton){
        sender.isSelected = !sender.isSelected
        
        if sender == reasearchButton {
            writingButton.isSelected = false
            revisionButton.isSelected = false
        } else if sender == writingButton {
            reasearchButton.isSelected = false
            revisionButton.isSelected = false
        } else {
            writingButton.isSelected = false
            reasearchButton.isSelected = false
        }
    }
    
    //Exit new project popup
    @IBAction func cancleNewProject(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    @IBAction func createButtonSelected(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
}
