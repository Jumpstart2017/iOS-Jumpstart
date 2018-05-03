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

        loadSampleTasks() //test data
        
        // View styling
        self.tableView.separatorColor = .clear //hide separator between cells
        
      
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        
        //based on the integer value for 'reminder' get string value
        let reminderString = [
            "Daily",
            "Weekly",
            "Monthly"
        ]
        
        //set label and slider values
        cell.descriptionLabel.text = task.description
        cell.reminderLabel.text = reminderString[task.reminder!] + " Reminder"
        cell.deadlineLabel.text = "Deadline: " + task.deadline!
        cell.progressSlider.value = Float(task.progress!) / 100.0
    
        return cell
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(taskList[indexPath.row].progress == 100) { return 0 }
        return 117.5
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: Private Methods
    
    //create three tasks and append them to list
    private func loadSampleTasks() {
        //modify this later to pull from database
        let Task1 = Task(
            deadline: "11/24/17", 
            description: "Paper",
            progress: 75, 
            reminder: 0,
            project: "PHD"
        )
        
        let Task2 = Task(
            deadline: "12/13/18", 
            description: "Dissertaion", 
            progress: 24, 
            reminder: 1,
            project: "Your mom's house"
        )
        
        let Task3 = Task(
            deadline: "3/30/18", 
            description: "Introduction to book",
            progress: 10, 
            reminder: 2,
            project: "Move on"
        )
        
        taskList += [Task1, Task2, Task3] 
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
            var cell = self.tableView.cellForRow(at: indexPath)
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
        
        // Remove from view
        [self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)]
    }
    
    /*
    // Create a new task, update view, update database
    @IBAction func newTask(_ sender: Any) {
        // Open new task popup
        let storyboard = UIStoryboard(name: "Tasks", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NewTaskPopupView")
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    */
}
