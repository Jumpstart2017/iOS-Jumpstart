//
//  ExpandableHeader.swift
//  Jumpstart
//
//  Created by Gabriel I Leyva Merino on 2/8/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import UIKit
import LUExpandableTableView

class ExpandableHeader:  LUExpandableTableViewSectionHeader{
    @IBOutlet weak var expandCollapseButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var view: UIView!
    override var isExpanded: Bool {
        didSet {
            // Change the title of the button when section header expand/collapse
            expandCollapseButton?.setTitle(isExpanded ? "^" : "v", for: .normal)
        }
    }
    
    // MARK: - Base Class Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnLabel)))
        label?.isUserInteractionEnabled = true
        label?.font = UIFont(name: "Roboto", size: 16)
        
        expandCollapseButton.tintColor = .white
    }
    
    // MARK: - IBActions
    
    @IBAction func expandCollapse(_ sender: UIButton) {
        // Send the message to his delegate that shold expand or collapse
        delegate?.expandableSectionHeader(self, shouldExpandOrCollapseAtSection: section)
    }
    
    // MARK: - Private Functions
    
    @objc private func didTapOnLabel(_ sender: UIGestureRecognizer) {
        // Send the message to his delegate that was selected
        delegate?.expandableSectionHeader(self, wasSelectedAtSection: section)
    }
}
