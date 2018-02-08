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
    var taskList = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSampleTasks() //test data
      
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        cell.reminderLabel.text = reminderString[task.reminder!]
        cell.deadlineLabel.text = task.deadline
        cell.progressSlider.value = Float(task.progress!) / 100.0
    
        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
        var Task1 = Task(
            deadline: "11/24/17", 
            description: "Paper",
            progress: 75, 
            reminder: 0
        )
        
        var Task2 = Task(
            deadline: "12/13/18", 
            description: "Dissertaion", 
            progress: 24, 
            reminder: 1
        )
        
        var Task3 = Task(
            deadline: "3/30/18", 
            description: "Introduction to book",
            progress: 10, 
            reminder: 2
        )
        
        taskList += [Task1, Task2, Task3] 
    }
}
