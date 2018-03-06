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
    @IBOutlet weak var writingStagesSeg: UISegmentedControl!
    
    let datePicker = UIDatePicker()
    
    var date: Date!
    var dateSelected: Bool!
    var newProject: Project?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.prepareButtons()
        self.setWritingStages()
        self.prepareProjectNameTextField()
        self.prepareProjectDeadlineTextField()
        
        newProject = Project()
        
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
        newProjectNameTextField.addTarget(self, action: #selector(editingChanged),for: .editingChanged)
        
    }
    
    func prepareProjectDeadlineTextField(){
        newProjectDeadlineTextField.placeholder = "Deadline"
        newProjectDeadlineTextField.isClearIconButtonEnabled = true
        newProjectDeadlineTextField.dividerActiveColor = .jBlue
        newProjectDeadlineTextField.dividerNormalColor = .jBlue
        newProjectDeadlineTextField.placeholderActiveColor = .jBlue
        dateSelected = false
        
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
        self.date = datePicker.date
        dateSelected = true
        editingChanged(sender: newProjectDeadlineTextField)
        self.view.endEditing(true)
        
    }
    
    func prepareButtons() {
        createNewProjectButton.backgroundColor = .jGreen
        createNewProjectButton.setTitleColor(.white, for: .normal)
        createNewProjectButton.isEnabled = false
        
        cancelNewProjectButton.setTitleColor(.red, for: .normal)
        
    }
    
    func setWritingStages() {
        writingStagesSeg.subviews[0].tintColor = UIColor.jIndependent
        writingStagesSeg.subviews[1].tintColor = UIColor.jOrange
        writingStagesSeg.subviews[2].tintColor = UIColor.jPurple
        
    }
 
    @objc func editingChanged(sender: TextField) {
        
        if (newProjectNameTextField.isEmpty || dateSelected == false){
            createNewProjectButton.isEnabled = false
        }
        else{
        createNewProjectButton.isEnabled = true
        }
    }
    
    func finalFormCheck() {
        newProject?.title = newProjectNameTextField.text
        newProject?.deadline = self.date
        newProject?.type = writingStagesSeg.selectedSegmentIndex
        //TODO: ADD Model Check
    }
    
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        
        finalFormCheck()
        let create = NewProjectViewModel()
        create.project = self.newProject
        create.createProject() { responseObject, error in
            
        }
        self.view.removeFromSuperview()
    }
    
    //Exit new project popup
    @IBAction func cancleNewProject(_ sender: Any) {
        self.view.removeFromSuperview()
    }

    
    /*func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }*/
    
    
}
