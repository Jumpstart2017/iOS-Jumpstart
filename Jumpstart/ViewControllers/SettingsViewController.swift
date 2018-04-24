//
//  SettingsViewController.swift
//  Jumpstart
//
//  Created by Gabriel I Leyva Merino on 3/28/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import Foundation
import UIKit
import Material
import MaterialComponents
import FirebaseAuth

class SettingsViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    @IBOutlet weak var logoutButton: MDCRaisedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareLogoutButton()
    }
    
    func prepareLogoutButton() {
        self.logoutButton.backgroundColor = .jRed
        self.logoutButton.setTitleColor(.white, for: .normal)
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            performSegue(withIdentifier: "Logout", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
}
