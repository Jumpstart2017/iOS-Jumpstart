//
//  LandingPageViewController.swift
//  Jumpstart
//
//  Created by Gabriel I Leyva Merino on 11/14/17.
//  Copyright © 2017 Jumpstart. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents

class LandingPageViewController : UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var tryNowButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = .jBlue
        self.prepareButtons()
    }
    
    func prepareButtons() {
        signUpButton.backgroundColor = .white
        signUpButton.setTitleColor(.jBlue, for: .normal)
        
        tryNowButton.backgroundColor = .white
        tryNowButton.setTitleColor(.jGreen, for: .normal)
    }
    
}
