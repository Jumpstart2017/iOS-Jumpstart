//
//  SubprojectViewController.swift
//  Jumpstart
//
//  Created by Etta Godwin on 2/1/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import MaterialComponents
import Material
import UICircularProgressRing
import FirebaseAuth

class SubprojectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var deadlineTitle: UILabel!
    @IBOutlet weak var writingStages: UISegmentedControl!
    @IBOutlet weak var totalProgressCircle: UICircularProgressRingView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deadlineEdit: UITextField!
    @IBOutlet weak var subprojectNav: UINavigationBar!
    @IBOutlet weak var addSubprojectButton: UIBarButtonItem!
    
    let dateFormatter = DateFormatter()
    let datePicker = UIDatePicker()

    
    var specificProject = Project()
    var pid: String!
    var subProjects: [SubProject]!
    var user: UserModel?
    var selectedIndex = Int()
    var subProjectViewModel: SubProjectViewModel!
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.user = UserModel()
        self.user?.uid =  Auth.auth().currentUser?.uid

        subProjectViewModel = SubProjectViewModel()
        subProjects = [SubProject]()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.loadSubProjects()
        
        setSubprojectNavBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = .jBlue
        self.navigationController?.navigationBar.backgroundColor = .jBlue
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // [START_EXCLUDE]
            self.user?.uid =  Auth.auth().currentUser?.uid
            // [END_EXCLUDE]
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // [START remove_auth_listener]
        Auth.auth().removeStateDidChangeListener(handle!)
        // [END remove_auth_listener]
    }
    
    func loadSubProjects(){
        subProjectViewModel.project = self.specificProject
        subProjectViewModel.getSubProjects(){ responseObject, error in
            if responseObject != nil {
                let sub = responseObject
                let p = Project(JSON: sub!)
                p?.subprojects = [SubProject]()
                p?.subprojects?.removeAll()
                
                if responseObject!["subprojects"] != nil {
                    let array = (responseObject!["subprojects"] as! NSArray).mutableCopy() as! NSMutableArray
                    for i in array {
                        let x = i as! [String: Any]
                        let subProj = SubProject(JSON: x)
                        p?.subprojects?.append(subProj!)
                    }
                    self.specificProject?.subprojects = [SubProject]()
                    self.specificProject?.subprojects = p?.subprojects
                }
      
               self.specificProject = p
                
               self.tableView.reloadData()
               self.setWritingStages()
               self.setProjectDeadline()
               self.setProjectProgress()
            
            }
            
            if error != nil {
                print(error ?? "nopey")
            }
        }
    }
        
    //MARK: TableView Delegate and Datasource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.specificProject?.subprojects != nil {
            return (self.specificProject?.subprojects?.count)!
        } else {
            return 0
        }
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProjectTableViewCell
        //set title
        cell.progressTitle.text = self.specificProject?.subprojects![indexPath.row].title
        cell.progressTitle.textColor = UIColor.black
        
        //set date
        cell.progressDeadline.text = self.specificProject?.subprojects![indexPath.row].deadline
        
        //set progress circle
       // cell.progressCircle.innerRingColor = UIColor.jGreen
        //cell.progressCircle.value = CGFloat(subProjects![indexPath.row].progress!)
        
        tableView.separatorStyle = .none
        
        return cell
    }
    
    
    func setWritingStages() {
        writingStages.subviews[0].tintColor = UIColor.jIndependent
        writingStages.subviews[1].tintColor = UIColor.jOrange
        writingStages.subviews[2].tintColor = UIColor.jPurple
        
        writingStages.selectedSegmentIndex = (specificProject?.type)!
    }
    
    
    func setProjectDeadline() {
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        deadlineEdit.text = specificProject?.deadline
      
        //Making Text Box have Date Picker Keyboard
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        deadlineEdit.inputAccessoryView = toolbar
        deadlineEdit.inputView = datePicker
        
    }
    
    //Closes Date Picker
    @objc func donePressed() {
        
        deadlineEdit.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func setProjectProgress(){
        //set progress circle
        totalProgressCircle.innerRingColor = UIColor.jGreen
        totalProgressCircle.value = CGFloat((specificProject?.progress)!)
    }
    
    func setSubprojectNavBar(){
        subprojectNav.barTintColor = .jBlue
        subprojectNav.backgroundColor = .jBlue
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        subprojectNav.titleTextAttributes = textAttributes
        addSubprojectButton.tintColor = .white
    }
    
    @IBAction func openSubProjectPopup(_ sender: Any) {
        let popUpVC = UIStoryboard(name: "Projects", bundle: nil).instantiateViewController(withIdentifier: "newSubProjectPopUpID") as! NewSubProjectPopUpViewController
        //popUpVC.SubprojectViewController = self
       // popUpVC.user = self.user
        self.addChildViewController(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.pid = self.pid
        popUpVC.didMove(toParentViewController: self)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier: "tasks", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.tintColor = .white
        backItem.title = "SubProjects"
        navigationItem.backBarButtonItem = backItem
        if segue.identifier == "tasks" {
            let destination = segue.destination as! TasksViewController
            destination.subProject = self.specificProject?.subprojects![selectedIndex]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
