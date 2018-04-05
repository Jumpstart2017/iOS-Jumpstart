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
            
        tryNowButton.backgroundColor = .white
        tryNowButton.setTitleColor(.jGreen, for: .normal)
  
    }
    
    func prepareLabels(){
        titleLabel.font = UIFont.boldSystemFont(ofSize: 55)
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.numberOfLines = 2
        
        getStartedLabel.textColor = .jIndependent
        getStartedLabel.font =  UIFont.boldSystemFont(ofSize: 40)
        getUnstuckLabel.textColor = .jOrange
        getUnstuckLabel.font =  UIFont.boldSystemFont(ofSize: 40)
        getEnergizedLabel.textColor = .jPurple
        getEnergizedLabel.font = UIFont.boldSystemFont(ofSize: 40)
    }
    
}
