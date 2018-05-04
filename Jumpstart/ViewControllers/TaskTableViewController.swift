//
//  TaskTableViewController.swift
//  Jumpstart
//
//  Created by Sean Burrows on 12/1/17.
//  Copyright © 2017 Jumpstart. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class TaskTableViewController: UITableViewController {
    
    var taskList = [Task]()
    var user: UserModel?
    var taskViewModel: TaskViewModel!
    var handel: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.user = UserModel()
        self.user?.uid = Auth.auth().currentUser?.uid
        
        self.taskViewModel = TaskViewModel()

        loadTasks()
        
        // View styling
        self.tableView.separatorColor = .clear //hide separator between cells
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = .jBlue
        self.navigationController?.navigationBar.backgroundColor = .jBlue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //update template identifier
        let cellIdentifier = "TasksTableViewCell"
        
        //downcast cell to TasksTableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TasksTableViewCell else {
                fatalError("Dequeued cell not instance TasksTableViewCell")
        }
            
        //get task for row index
        let task = taskList[indexPath.row]
        
        /*
        //based on the integer value for 'reminder' get string value
        let reminderString = [
            "Daily",
            "Weekly",
            "Monthly"
        ]
        */
        
        //set label and slider values
        cell.descriptionLabel.text = task.title
//        cell.reminderLabel.text = reminderString[task.reminder!] + " Reminder"
        cell.deadlineLabel.text = "Deadline: " + task.deadline!
        cell.progressSlider.value = Float(task.progress!) / 100.0
    
        return cell
    }

    /*
    @IBAction func newTask(_ sender: Any) {
        print("New task clicked")
        
        // Open new task popup
        let storyboard = UIStoryboard(name: "Tasks", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NewTaskPopupView")
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    */
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(taskList[indexPath.row].progress == 100) { return 0 }
        return 117.5
    }
    
    private func loadTasks() {
        taskViewModel.user = self.user
        taskViewModel.getAllTasks() { responseObject, error in
            if responseObject != nil {
                self.taskList.removeAll()
                for i in responseObject! {
                    let temp = i.value as! [String: Any]
                    for x in temp {
                        let task = Task()
                        //task?.tid = x.key
                        let p:AnyObject = x.value as AnyObject
                        task?.deadline = p["deadline"] as? String
                        task?.progress = p["progress"] as? Int
                        task?.title = p["description"] as? String
                        task?.reminder = p["reminder"] as? Int
                        
                        print(task)
                        
                        self.taskList.append(task!)
                    }
                }
                
                self.tableView.reloadData()
            }
            
            
            if error != nil {
                print(error)
            }
        }
    }
    
    //MARK: Actions
    @IBAction func updateProgress(_ sender: UISlider) {
        // Get the cell position to delete
        let position: CGPoint = (sender as AnyObject).convert(CGPoint(), to: tableView)
        let indexPath: IndexPath = self.tableView.indexPathForRow(at: position)!
        
        // Update value for progress for task in data source
        taskList[indexPath.row].progress = Int(sender.value * 100)
        
        // If task is completed, then need to hide from view (not delete)
        if(sender.value == 1) {
            let cell = self.tableView.cellForRow(at: indexPath)
            cell?.isHidden = true
            self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        }
    }
    
    @IBAction func deleteTask(_ sender: Any) {
        // Get the cell position to delete
        let position: CGPoint = (sender as AnyObject).convert(CGPoint(), to: tableView)
        let indexPath: IndexPath = self.tableView.indexPathForRow(at: position)!
        
        // Remove from data source
        taskList.remove(at: indexPath.row)
        
        // Remove from database

//        var id = taskList[indexPath.row].tid
//        taskViewModel.task.tid = id
//        taskViewModel.deleteTask()
        

        // Remove from view
        self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
     }
}
