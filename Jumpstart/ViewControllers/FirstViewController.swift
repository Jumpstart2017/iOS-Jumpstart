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
import FirebaseAuth

class FirstViewController: UIViewController, LUExpandableTableViewDelegate, LUExpandableTableViewDataSource {

    @IBOutlet weak var tableView: LUExpandableTableView!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    var names = ["Research", "Writing", "Revision"]
    var videoModels = makeVideoModels()
    
    var videoViewModel = VideoViewModel()
    var rVideos = [VideoModel]()
    var wVideos = [VideoModel]()
    var reVideos = [VideoModel]()
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loadVideos()
        
        tableView.bounces = false
        tableView.expandableTableViewDataSource = self
        tableView.expandableTableViewDelegate = self
        tableView.register(UINib(nibName: "ExpandableHeader", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "ExpandableHeaderId")

        self.view.backgroundColor = Color.grey.lighten5
        self.tabItem.titleColor = .jBlue
        self.tableView.separatorColor = .clear
        
        self.handleInfoLabel()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = .jBlue
        self.navigationController?.navigationBar.backgroundColor = .jBlue
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // [START_EXCLUDE]
            print(user ?? "Nope")
            self.tableView.reloadData()
            self.handleInfoLabel()
            
            if user == nil {
                let buttons = self.tabBarController?.tabBar.items
                buttons![1].isEnabled = false
                buttons![2].isEnabled = false
            }

            // [END_EXCLUDE]
        }
    }
    
    @IBAction func accountButtonPressed(_ sender: Any) {
          if Auth.auth().currentUser == nil {
            performSegue(withIdentifier: "Login", sender: self)
          } else {
            performSegue(withIdentifier: "Settings", sender: self)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // [START remove_auth_listener]
        Auth.auth().removeStateDidChangeListener(handle!)
        // [END remove_auth_listener]
    }
    
    func handleInfoLabel() {
        if Auth.auth().currentUser == nil {
            self.infoLabel.isHidden = false
        } else {
            self.infoLabel.isHidden = true
        }
    }
    
    func loadVideos() {
        videoViewModel.getVideos() { responseObject, error in
            for i in responseObject! {
                let val = i.value as! [String : Any]
                let video = VideoModel(JSON: val)
                
                if video?.type == "Research" {
                    self.rVideos.append(video!)
                } else if video?.type == "Writing" {
                    self.wVideos.append(video!)
                } else {
                    self.reVideos.append(video!)
                }
            }
            self.tableView.reloadData()
        }
    }

}



// MARK: - LUExpandableTableViewDataSource

extension FirstViewController {
    func numberOfSections(in expandableTableView: LUExpandableTableView) -> Int {
         if Auth.auth().currentUser == nil {
            return 1
         } else {
            return 3
        }
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0) {
            if rVideos.count == 0 {
                return 0
            } else {
                return rVideos.count
            }
        } else if (section == 1) {
            if wVideos.count == 0 {
                return 0
            } else {
                return wVideos.count
            }
        } else if (section == 2) {
            if reVideos.count == 0 {
                return 0
            } else {
                return reVideos.count
            }
        }
        
        return 0
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = expandableTableView.dequeueReusableCell(withIdentifier: "VideoCell") as? VideoCell else {
            assertionFailure("Cell shouldn't be nil")
            return UITableViewCell()
        }
        
        if indexPath.section == 0 {
            cell.initVideoCellWith(videoModel: rVideos[indexPath.row])
        } else if indexPath.section == 1 {
            cell.initVideoCellWith(videoModel: wVideos[indexPath.row])
        } else {
            cell.initVideoCellWith(videoModel: reVideos[indexPath.row])
        }
        
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
        return 320
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForHeaderInSection section: Int) -> CGFloat {
        /// Returning `UITableViewAutomaticDimension` value on iOS 9 will cause reloading all cells due to an iOS 9 bug with automatic dimensions
        return 75
    }
    
    // MARK: - Optional
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectSectionHeader sectionHeader: LUExpandableTableViewSectionHeader, atSection section: Int) {
 
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    }
    
    func expandableTableView(_ expandableTableView: LUExpandableTableView, willDisplaySectionHeader sectionHeader: LUExpandableTableViewSectionHeader, forSection section: Int) {
 
    }
}

