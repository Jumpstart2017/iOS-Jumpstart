//
//  TaskTableViewController.swift
//  Jumpstart
//
//  Created by Sean Burrows on 12/1/17.
//  Copyright © 2017 Jumpstart. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController {

    //MARK: Properties
    
    // Edit loadSampleTasks() to change contents of the task list
    var taskList = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }

    // This function loads the table view with the tasks from taskList
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
    
    //create three tasks and append them to list
    private func loadTasks() {

    }
}
