//
//  NewSubProjectPopUpViewController.swift
//  Jumpstart
//
//  Created by Etta Godwin on 2/22/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import MaterialComponents
import Material

class NewSubProjectPopUpViewController: UIViewController {
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var createNewButton: MDCRaisedButton!
    @IBOutlet weak var newSubProjectName: TextField!
    @IBOutlet weak var newSubProjectDeadline: TextField!
    
    let datePicker = UIDatePicker()
    var dateSelected: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.prepareButtons()
        self.prepareProjectNameTextField()
        self.prepareProjectDeadlineTextField()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareProjectNameTextField(){
        newSubProjectName.placeholder = "Subproject Name"
        newSubProjectName.isClearIconButtonEnabled = true
        newSubProjectName.dividerActiveColor = .jBlue
        newSubProjectName.dividerNormalColor = .jBlue
        newSubProjectName.placeholderActiveColor = .jBlue
        newSubProjectName.addTarget(self, action: #selector(editingChanged),for: .editingChanged)

    }
    
    func prepareProjectDeadlineTextField(){
        newSubProjectDeadline.placeholder = "Deadline"
        newSubProjectDeadline.isClearIconButtonEnabled = true
        newSubProjectDeadline.dividerActiveColor = .jBlue
        newSubProjectDeadline.dividerNormalColor = .jBlue
        newSubProjectDeadline.placeholderActiveColor = .jBlue
        dateSelected = false
        
        //Making Text Box have Date Picker Keyboard
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        newSubProjectDeadline.inputAccessoryView = toolbar
        newSubProjectDeadline.inputView = datePicker
        
    }
    
    //Closes Date Picker
    @objc func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        newSubProjectDeadline.text = dateFormatter.string(from: datePicker.date)
        dateSelected = true
        editingChanged(sender: newSubProjectDeadline)
        self.view.endEditing(true)
    }
    
    func prepareButtons() {
        createNewButton.backgroundColor = .jGreen
        createNewButton.setTitleColor(.white, for: .normal)
        createNewButton.isEnabled = false
        
        cancelButton.setTitleColor(.red, for: .normal)
        
    }
    

    @IBAction func submitButtonPressed(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    @objc func editingChanged(sender: TextField) {
        
        if (newSubProjectName.isEmpty || dateSelected == false){
            createNewButton.isEnabled = false
        }
        else{
            createNewButton.isEnabled = true
        }
    }
    
    //Exit new project popup
    @IBAction func cancleNewProject(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    

}
