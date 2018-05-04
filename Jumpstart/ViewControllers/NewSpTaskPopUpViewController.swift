//
//  NewSpTaskPopUp.swift
//  Jumpstart
//
//  Created by Etta Godwin on 5/3/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import Alamofire
import MaterialComponents
import Material

class NewSpTaskPopUpViewController: UIViewController {
    
    
   
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var createNewButton: MDCRaisedButton!
    @IBOutlet weak var newTaskName: TextField!
    @IBOutlet weak var newTaskDeadline: TextField!
    
    let datePicker = UIDatePicker()
    var dateSelected: Bool!
    var newTask: Task?
    var spid: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.prepareButtons()
        self.prepareProjectNameTextField()
        self.prepareProjectDeadlineTextField()
        
        newTask = Task()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareProjectNameTextField(){
        newTaskName.placeholder = "Subproject Name"
        newTaskName.isClearIconButtonEnabled = true
        newTaskName.dividerActiveColor = .jBlue
        newTaskName.dividerNormalColor = .jBlue
        newTaskName.placeholderActiveColor = .jBlue
        newTaskName.addTarget(self, action: #selector(editingChanged),for: .editingChanged)
        
    }
    
    @objc func dismissKeyboard (){
        view.endEditing(true)
    }
    
    func prepareProjectDeadlineTextField(){
        newTaskDeadline.placeholder = "Deadline"
        newTaskDeadline.isClearIconButtonEnabled = true
        newTaskDeadline.dividerActiveColor = .jBlue
        newTaskDeadline.dividerNormalColor = .jBlue
        newTaskDeadline.placeholderActiveColor = .jBlue
        dateSelected = false
        
        //Making Text Box have Date Picker Keyboard
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        newTaskDeadline.inputAccessoryView = toolbar
        newTaskDeadline.inputView = datePicker
        
    }
    
    //Closes Date Picker
    @objc func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        newTaskDeadline.text = dateFormatter.string(from: datePicker.date)
        dateSelected = true
        editingChanged(sender: newTaskDeadline)
        self.view.endEditing(true)
    }
    
    func prepareButtons() {
        createNewButton.backgroundColor = .jGreen
        createNewButton.setTitleColor(.white, for: .normal)
        createNewButton.isEnabled = false
        
        cancelButton.setTitleColor(.red, for: .normal)
        
    }
    func finalFormCheck() {
        newTask?.title = newTaskName.text
        newTask?.deadline = newTaskDeadline.text
        newTask?.spid = self.spid
        //TODO: ADD Model Check
    }
    
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        finalFormCheck()
        let create = TaskViewModel()
        create.task = self.newTask
        create.createTask() { responseObject, error in
            
        }
        
        
        self.view.removeFromSuperview()
    }
    
    @objc func editingChanged(sender: TextField) {
        
        if (newTaskName.isEmpty || dateSelected == false){
            createNewButton.isEnabled = false
        }
        else{
            createNewButton.isEnabled = true
        }
    }
    
    //Exit new project popup
    @IBAction func cancleNewTask(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
}
