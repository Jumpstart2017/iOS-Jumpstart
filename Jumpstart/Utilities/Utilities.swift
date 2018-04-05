//
//  Utilities.swift
//  Jumpstart
//
//  Created by Gabriel I Leyva Merino on 3/28/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import Foundation
import UIKit

func createActivityIndicator(viewController: UIViewController) -> UIActivityIndicatorView {
    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    activityView.center = viewController.view.center
    activityView.startAnimating()
    
    return activityView
}


