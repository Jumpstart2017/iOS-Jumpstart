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
    @IBOutlet weak var getStartedLabel: UILabel!
    @IBOutlet weak var getUnstuckLabel: UILabel!
    @IBOutlet weak var getEnergizedLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = .jBlue
        self.prepareButtons()
        self.prepareLabels()
    }
    
    func prepareButtons() {
        signUpButton.backgroundColor = .white
        signUpButton.setTitleColor(.jBlue, for: .normal)
        signUpButton.layer.cornerRadius = 3.0
        signUpButton.layer.borderWidth = 2.0
        signUpButton.layer.shadowOpacity = 1.0
        signUpButton.layer.shadowRadius = 1.0
        signUpButton.layer.shadowOffset = CGSize(width: 0, height: 3)
            
        tryNowButton.backgroundColor = .white
        tryNowButton.setTitleColor(.jGreen, for: .normal)
        tryNowButton.layer.cornerRadius = 3.0
        tryNowButton.layer.borderWidth = 2.0
        tryNowButton.layer.shadowOpacity = 1.0
        tryNowButton.layer.shadowRadius = 1.0
        tryNowButton.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    func prepareLabels(){
        titleLabel.font = UIFont.boldSystemFont(ofSize: 55)
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.numberOfLines = 0
        getStartedLabel.textColor = .jRed
        getStartedLabel.font =  UIFont.boldSystemFont(ofSize: 40)
        getUnstuckLabel.textColor = .jYellow
        getUnstuckLabel.font =  UIFont.boldSystemFont(ofSize: 40)
        getEnergizedLabel.textColor = .jRed
        getEnergizedLabel.font = UIFont.boldSystemFont(ofSize: 40)
    }
    
}
