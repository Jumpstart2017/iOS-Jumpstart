//
//  LoginViewController.swift
//  Jumpstart
//
//  Created by Gabriel I Leyva Merino on 11/14/17.
//  Copyright © 2017 Jumpstart. All rights reserved.
//

import UIKit
import MaterialComponents
import Material


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var loginButton: MDCRaisedButton!
    @IBOutlet weak var passwordTextField: TextField!
    
    @IBOutlet weak var registerButton: MDCRaisedButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareButtons()
        self.prepareEmailTextField()
        self.preparePasswordTextField()
        self.prepareDescriptionLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = .jBlue
        self.navigationController?.navigationBar.backgroundColor = .jBlue
    }
    
    func prepareEmailTextField() {
        emailTextField.placeholder = "email"
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
        passwordTextField.placeholder = "password"
        passwordTextField.isClearIconButtonEnabled = true
        passwordTextField.dividerActiveColor = .jBlue
        passwordTextField.dividerNormalColor = .jBlue
        passwordTextField.placeholderActiveColor = .jBlue
        
        
        let leftView = UIImageView()
        leftView.image = Icon.icon("lock")
        passwordTextField.leftView = leftView
        
        passwordTextField.delegate = self
    }
    
    func prepareButtons() {
        loginButton.backgroundColor = .jGreen
        loginButton.setTitleColor(.white, for: .normal)
        
        registerButton.backgroundColor = .jBlue
        registerButton.setTitleColor(.white, for: .normal)
        
    }
    
    func prepareDescriptionLabel() {
        descriptionLabel.textColor = .lightGray
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
