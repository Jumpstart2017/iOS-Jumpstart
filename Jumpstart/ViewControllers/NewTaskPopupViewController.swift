//
//  NewTaskPopupViewController.swift
//  Jumpstart
//
//  Created by Sean Burrows on 2/13/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import UIKit

class NewTaskPopup: UIViewController {
    @IBOutlet weak var popupview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preparePopup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension NewTaskPopup {
    
    fileprivate func preparePopup() {
        popupview.layer.cornerRadius = 15
        popupview.layer.shadowColor = UIColor.black.cgColor
        popupview.layer.shadowOffset = CGSize(width: 0, height: 10)
        popupview.layer.shadowOpacity = 0.9
        popupview.layer.shadowRadius = 5
    }
    
}
