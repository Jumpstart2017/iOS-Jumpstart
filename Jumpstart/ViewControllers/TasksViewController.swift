//
//  TasksViewController.swift
//  Jumpstart
//
//  Created by Gabriel I Leyva Merino on 4/30/18.
//  Copyright © 2018 Jumpstart. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import MaterialComponents
import Material
import UICircularProgressRing
import FirebaseAuth


class TasksViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var deadlineTitle: UILabel!
    @IBOutlet weak var totalProgressCircle: UICircularProgressRingView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deadlineEdit: UITextField!
    @IBOutlet weak var tasksNav: UINavigationBar!
    @IBOutlet weak var addTaskButton: UIBarButtonItem!
    
    let dateFormatter = DateFormatter()
    let datePicker = UIDatePicker()
    
    var subProject = SubProject();
    var user: UserModel?
    var selectedIndex = Int()
    var taskViewModel: TaskViewModel!
    var handle: AuthStateDidChangeListenerHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.user = UserModel()
        self.user?.uid =  Auth.auth().currentUser?.uid
        
        
        taskViewModel = TaskViewModel()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.loadTasks()
        
        self.setTasksNavBar()
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
    
    func loadTasks(){
        taskViewModel.subProject = self.subProject
        taskViewModel.getTasks(){ responseObject, error in
            if responseObject != nil {
                let task = responseObject
                let sp = SubProject(JSON: task!)
                sp?.tasks = [Task]()
                sp?.tasks?.removeAll()
                if responseObject!["tasks"] != nil {
                    let array = (responseObject!["tasks"] as! NSArray).mutableCopy() as! NSMutableArray
                    for i in array {
                        let x = i as! [String: Any]
                        let tsk = Task(JSON: x)
                        sp?.tasks?.append(tsk!)
                    }
                    self.subProject?.tasks = [Task]()
                    self.subProject?.tasks = sp?.tasks
                }
                
                self.subProject = sp
                /*let mytask = Task()
                mytask?.deadline = "11/12/18"
                mytask?.title =  "Thesis"
                mytask?.progress = 0
                self.subProject?.tasks?.append(mytask!)*/
                self.tableView.reloadData()
                self.setSubProjectDeadline()
                self.setSubProjectProgress()
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
       if self.subProject?.tasks != nil {
            return (self.subProject?.tasks?.count)!
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TasksTableViewCell else {
                fatalError("Dequeued cell not instance of TaskTableViewCell")
        }
        
        //set title
        cell.descriptionLabel.text = self.subProject?.tasks![indexPath.row].title
        cell.descriptionLabel.textColor = UIColor.black

        //set date
        cell.deadlineLabel.text = self.subProject?.tasks![indexPath.row].deadline

        //set progress slider
        /*cell.progressSlider.value = Float((self.subProject?.tasks![indexPath.row].progress!)!) / 100.0*/
        cell.progressSlider.value = 0

        
        tableView.separatorStyle = .none
        
        return cell
    }
    
    func setSubProjectDeadline() {
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        deadlineEdit.text = subProject?.deadline
        
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
    
    func setSubProjectProgress(){
        //set progress circle
        totalProgressCircle.innerRingColor = UIColor.jGreen
        totalProgressCircle.value = CGFloat((subProject?.progress)!)
    }
    
    func setTasksNavBar(){
        tasksNav.barTintColor = .jBlue
        tasksNav.backgroundColor = .jBlue
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        tasksNav.titleTextAttributes = textAttributes
        addTaskButton.tintColor = .white
    }
    
    
    @IBAction func newTaskPopUp(_ sender: Any) {
        let popUpVC = UIStoryboard(name: "Projects", bundle: nil).instantiateViewController(withIdentifier: "newSpTasksPopUpID") as! NewSpTaskPopUpViewController
        //popUpVC.SubprojectViewController = self
        // popUpVC.user = self.user
        self.addChildViewController(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.spid = subProject?.spid
        popUpVC.didMove(toParentViewController: self)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
