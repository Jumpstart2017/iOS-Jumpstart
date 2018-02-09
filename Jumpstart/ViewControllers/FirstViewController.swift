//
//  FirstViewController.swift
//  Jumpstart
//
//  Created by Gabriel I Leyva Merino on 11/9/17.
//  Copyright © 2017 Jumpstart. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import MaterialComponents
import Material
import LUExpandableTableView

class FirstViewController: UIViewController, LUExpandableTableViewDelegate, LUExpandableTableViewDataSource {

    @IBOutlet weak var tableView: LUExpandableTableView!
    
    
    var names = ["Research", "Writing", "Revision"]
    var videoModels = makeVideoModels()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.bounces = false
        tableView.expandableTableViewDataSource = self
        tableView.expandableTableViewDelegate = self
        tableView.register(UINib(nibName: "ExpandableHeader", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "ExpandableHeaderId")

        self.view.backgroundColor = Color.grey.lighten5

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = .jBlue
        self.navigationController?.navigationBar.backgroundColor = .jBlue
    }
    


}

// MARK: - LUExpandableTableViewDataSource

extension FirstViewController {
    func numberOfSections(in expandableTableView: LUExpandableTableView) -> Int {
        return 3
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = expandableTableView.dequeueReusableCell(withIdentifier: "VideoCell") as? VideoCell else {
            assertionFailure("Cell shouldn't be nil")
            return UITableViewCell()
        }
        
        //cell.label.text = "Cell at row \(indexPath.row) section \(indexPath.section)"
        cell.initVideoCellWith(videoModel: videoModels[indexPath.section])
        
        
        return cell
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, sectionHeaderOfSection section: Int) -> LUExpandableTableViewSectionHeader {
        guard let sectionHeader = expandableTableView.dequeueReusableHeaderFooterView(withIdentifier: "ExpandableHeaderId") as? ExpandableHeader else {
            assertionFailure("Section header shouldn't be nil")
            return LUExpandableTableViewSectionHeader()
        }
        
        sectionHeader.label.text = names[section]
        
        switch section {
        case 0:
            sectionHeader.view.backgroundColor = .jPurple
            break
        case 1:
            sectionHeader.view.backgroundColor = .jOrange
            break
        case 3:
            sectionHeader.view.backgroundColor = .jIndependent
        default:
            break
        }
        
        return sectionHeader
    }
}

// MARK: - LUExpandableTableViewDelegate

extension FirstViewController {
    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        /// Returning `UITableViewAutomaticDimension` value on iOS 9 will cause reloading all cells due to an iOS 9 bug with automatic dimensions
        return 300
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForHeaderInSection section: Int) -> CGFloat {
        /// Returning `UITableViewAutomaticDimension` value on iOS 9 will cause reloading all cells due to an iOS 9 bug with automatic dimensions
        return 75
    }
    
    // MARK: - Optional
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select cell at section \(indexPath.section) row \(indexPath.row)")
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectSectionHeader sectionHeader: LUExpandableTableViewSectionHeader, atSection section: Int) {
        print("Did select cection header at section \(section)")
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("Will display cell at section \(indexPath.section) row \(indexPath.row)")
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, willDisplaySectionHeader sectionHeader: LUExpandableTableViewSectionHeader, forSection section: Int) {
        print("Will display section header for section \(section)")
    }
}

