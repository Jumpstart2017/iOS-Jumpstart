//
//  LoginViewModel.swift
//  Jumpstart
//
//  Created by Gabriel I Leyva Merino on 3/28/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

struct LoginViewModel {
    
    func login(email: String, password: String) {
    
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            print(user ?? "Nope")
        }
    }
    
}
