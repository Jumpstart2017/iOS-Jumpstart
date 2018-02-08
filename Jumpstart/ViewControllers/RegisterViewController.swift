//
//  RegisterViewController.swift
//  Jumpstart
//
//  Created by Gabriel I Leyva Merino on 11/15/17.
//  Copyright © 2017 Jumpstart. All rights reserved.
//

import UIKit
import MaterialComponents
import Material

class RegisterViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstNameTextField: TextField!
    @IBOutlet weak var lastNameTextField: TextField!
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var confirmPasswordTextField: TextField!
    @IBOutlet weak var submitButton: MDCRaisedButton!
    
    var newUser: NewUser?
    var formIsFilledOut = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareFirstNameTextField()
        self.prepareLastNameTextField()
        self.prepareEmailTextField()
        self.preparePasswordTextField()
        self.prepareConfirmPasswordTextField()
        self.prepareSubmitButton()
        self.prepareScrollView()
        
       newUser = NewUser()
    }
    
    func prepareFirstNameTextField() {
        firstNameTextField.placeholder = "First Name"
        firstNameTextField.isClearIconButtonEnabled = true
        firstNameTextField.dividerActiveColor = .jBlue
        firstNameTextField.dividerNormalColor = .jBlue
        firstNameTextField.placeholderActiveColor = .jBlue
        
        
        let leftView = UIImageView()
        leftView.image = Icon.pen
        firstNameTextField.leftView = leftView
        
        firstNameTextField.delegate = self
    }
    
    func prepareLastNameTextField() {
        lastNameTextField.placeholder = "Last Name"
        lastNameTextField.isClearIconButtonEnabled = true
        lastNameTextField.dividerActiveColor = .jBlue
        lastNameTextField.dividerNormalColor = .jBlue
        lastNameTextField.placeholderActiveColor = .jBlue
        
        
        let leftView = UIImageView()
        leftView.image = Icon.pen
        lastNameTextField.leftView = leftView
        
        lastNameTextField.delegate = self
    }
    
    func prepareEmailTextField() {
        emailTextField.placeholder = "Email"
        emailTextField.isClearIconButtonEnabled = true
        emailTextField.dividerActiveColor = .jBlue
        emailTextField.dividerNormalColor = .jBlue
        emailTextField.placeholderActiveColor = .jBlue
        
        
        let leftView = UIImageView()
        leftView.image = Icon.email
        emailTextField.leftView = leftView
        
        emailTextField.delegate = self
    }
    
    func preparePasswordTextField() {
        passwordTextField.placeholder = "Password"
        passwordTextField.isClearIconButtonEnabled = true
        passwordTextField.dividerActiveColor = .jBlue
        passwordTextField.dividerNormalColor = .jBlue
        passwordTextField.placeholderActiveColor = .jBlue
        
        
        let leftView = UIImageView()
        leftView.image = Icon.icon("lock")
        passwordTextField.leftView = leftView
        
        passwordTextField.delegate = self
    }
    
    func prepareConfirmPasswordTextField() {
        confirmPasswordTextField.placeholder = "Confirm Password"
        confirmPasswordTextField.isClearIconButtonEnabled = true
        confirmPasswordTextField.dividerActiveColor = .jBlue
        confirmPasswordTextField.dividerNormalColor = .jBlue
        confirmPasswordTextField.placeholderActiveColor = .jBlue
        
        
        let leftView = UIImageView()
        leftView.image = Icon.icon("lock")
        confirmPasswordTextField.leftView = leftView
        
        confirmPasswordTextField.delegate = self
    }
    
    func prepareSubmitButton() {
        submitButton.backgroundColor = .jGreen
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.isEnabled = false
    }
    
    func prepareScrollView() {
        scrollView.delegate = self
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 1100.0)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        firstNameTextField = checkTextFields(textField: firstNameTextField)
        lastNameTextField = checkTextFields(textField: lastNameTextField)
        
        if formIsFilledOut {
            submitButton.isEnabled = true
        }
        
        return false
    }
    
    func checkTextFields(textField: TextField) -> TextField {
        if textField.isEmpty {
            textField.dividerActiveColor = .jRed
            textField.dividerNormalColor = .jRed
            textField.placeholderActiveColor = .jRed
        } else {
            textField.dividerActiveColor = .jBlue
            textField.dividerNormalColor = .jBlue
            textField.placeholderActiveColor = .jBlue
        }
        
        return textField
    }
    
    func finalFormCheck() {
        newUser?.firstName = firstNameTextField.text
        newUser?.lastName = lastNameTextField.text
        newUser?.email = emailTextField.text
        newUser?.password = passwordTextField.text
        
        //TODO: ADD Model Check
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        let register = RegisterViewModel()
        register.user = self.newUser
        register.registerUser() { responseObject, error in
            
        }
        
    }
    
}
