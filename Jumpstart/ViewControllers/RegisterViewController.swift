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
import Validator
import FirebaseAuth

class RegisterViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstNameTextField: TextField!
    @IBOutlet weak var lastNameTextField: TextField!
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var confirmPasswordTextField: TextField!
    @IBOutlet weak var submitButton: MDCRaisedButton!
    
    var newUser: NewUser?
    var indicator:UIActivityIndicatorView!
    
    var states = ["fname": false, "lname": false, "email": false, "password": false, "cpassword": false]
    
    var emailValidator: ValidationRulePattern?
    var passwordValidator: ValidationRuleLength?
    var comparisonRule: ValidationRuleEquality<String>?
    var nameRule: ValidationRuleLength?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareValidators()
        self.prepareFirstNameTextField()
        self.prepareLastNameTextField()
        self.prepareEmailTextField()
        self.preparePasswordTextField()
        self.prepareConfirmPasswordTextField()
        self.prepareSubmitButton()
        self.prepareScrollView()
        
        indicator = createActivityIndicator(viewController: self)
        indicator.isHidden = true
        indicator.stopAnimating()
        self.view.addSubview(indicator)
        newUser = NewUser()
    }
    
    func prepareFirstNameTextField() {
        firstNameTextField.placeholder = "First Name"
        firstNameTextField.isClearIconButtonEnabled = true
        firstNameTextField.dividerActiveColor = .jBlue
        firstNameTextField.dividerNormalColor = .jBlue
        firstNameTextField.placeholderActiveColor = .jBlue
        
        var set = ValidationRuleSet<String>()
        set.add(rule: nameRule!)
        
        firstNameTextField.validationRules = set
        firstNameTextField.validateOnInputChange(enabled: true)
        firstNameTextField.validationHandler = { result in self.updateValidationState(result: result, textField: self.firstNameTextField, type: "fname") }
        
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
        
        var set = ValidationRuleSet<String>()
        set.add(rule: nameRule!)
        
        lastNameTextField.validationRules = set
        lastNameTextField.validateOnInputChange(enabled: true)
        lastNameTextField.validationHandler = { result in self.updateValidationState(result: result, textField: self.lastNameTextField, type: "lname") }
        
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
        
        var set = ValidationRuleSet<String>()
        set.add(rule: emailValidator!)
        
        emailTextField.validationRules = set
        emailTextField.validateOnInputChange(enabled: true)
        emailTextField.validationHandler = { result in self.updateValidationState(result: result, textField: self.emailTextField, type: "email") }
       
        
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
        
        var set = ValidationRuleSet<String>()
        set.add(rule: passwordValidator!)
        
        passwordTextField.validationRules = set
        passwordTextField.validateOnInputChange(enabled: true)
        passwordTextField.validationHandler = { result in self.updateValidationState(result: result, textField: self.passwordTextField, type:"password") }
        
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
        
        var set = ValidationRuleSet<String>()
        set.add(rule: passwordValidator!)
        set.add(rule: comparisonRule!)
        
        confirmPasswordTextField.validationRules = set
        confirmPasswordTextField.validateOnInputChange(enabled: true)
        confirmPasswordTextField.validationHandler = { result in self.updateValidationState(result: result, textField: self.confirmPasswordTextField, type:"cpassword") }
        
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
    
    func prepareValidators() {
       emailValidator =  ValidationRulePattern(pattern: EmailValidationPattern.standard, error: ValidationError(message: "Invalid email"))
       passwordValidator = ValidationRuleLength(min: 6, error: ValidationError(message: "Invalid password"))
       comparisonRule = ValidationRuleEquality<String>(target: passwordTextField.text!, error: ValidationError(message: "Passwords Don't Match"))
        nameRule = ValidationRuleLength(min: 1, max: 50,  error: ValidationError(message: "Invalid Name"))
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.prepareValidators()
        self.prepareConfirmPasswordTextField()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        
        return true
    }
    
    func finalCheck() {
        for  state in states {
            if state.value == false {
                self.submitButton.isEnabled = false
                break;
            } else {
                self.submitButton.isEnabled = true
            }
        }
    }
    
    func createUserModel() {
        if submitButton.isEnabled == true {
            newUser?.firstName = firstNameTextField.text!
            newUser?.lastName = lastNameTextField.text!
            newUser?.email = emailTextField.text!
            newUser?.password = passwordTextField.text!
        }
    }
    
    func updateValidationState(result: ValidationResult, textField: TextField, type: String) {
        switch result {
        case .valid:
            textField.dividerActiveColor = .jBlue
            textField.dividerNormalColor = .jBlue
            textField.placeholderActiveColor = .jBlue
            self.states[type] = true
        case .invalid( _):
            textField.dividerActiveColor = .jRed
            textField.dividerNormalColor = .jRed
            textField.placeholderActiveColor = .jRed
             self.states[type] = false
        }
        self.finalCheck()
        self.createUserModel()
    }

    func signIn() {
        self.indicator.isHidden = false
        self.indicator.startAnimating()
        Auth.auth().signIn(withEmail: self.newUser!.email!, password: self.newUser!.password!) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "Register", sender: self)
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
            }
            
            if error != nil {
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                print(error ?? "")
            }
        }
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        let register = RegisterViewModel()
        register.user = self.newUser
        register.registerUser() { responseObject, error in
            
        if responseObject != nil {
            let val = responseObject
            print("Value: ", val ?? "nope")
            self.newUser = NewUser(JSON: val!)
            print("New User: ", self.newUser ?? "nope")
            self.signIn()
        }
        }
        
    }
    
}
