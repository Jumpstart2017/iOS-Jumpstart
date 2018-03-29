//
//  SecondViewController.swift
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
import UICircularProgressRing

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var addProject: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var projectsModel = makeProjectModels()


    var projects: [Project]!
    var selectedIndex = Int()
    var projectViewModel: ProjectViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        projectViewModel = ProjectViewModel()
        projects = [Project]()
        self.loadProjects()
        self.tableView.delegate = self
        self.tableView.dataSource = self

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = .jBlue
        self.navigationController?.navigationBar.backgroundColor = .jBlue
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        addProject.tintColor = .white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: TableView Delegate and Datasource methods
    func loadProjects() {
        projectViewModel.getProjects() { responseObject, error in
            if responseObject != nil {
                for i in responseObject! {
                    let val = i.value as! [String : Any]
                    let proj = Project(JSON: val)
                    print(proj ?? "")
                    self.projects.append(proj!)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if projects.count > 0 {
            return projects.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProjectTableViewCell
        //set title
        cell.progressTitle.text = projects[indexPath.row].title
        cell.progressTitle.textColor = UIColor.black
        
        //set date
        cell.progressDeadline.text = projects[indexPath.row].deadline
       
        //set progress circle
        cell.progressCircle.innerRingColor = UIColor.jGreen
        cell.progressCircle.value = 10 //CGFloat(projects[indexPath.row].progress!)
        
        tableView.separatorStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier: "Index", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.tintColor = .white
        backItem.title = "Projects"
        navigationItem.backBarButtonItem = backItem
        if segue.identifier == "Index" {
            let destination = segue.destination as! SubprojectViewController
            destination.specificProject = projects[selectedIndex]
            destination.title = projects[selectedIndex].title
        }
        
    }
    
    
    @IBAction func showNewProjectPopUp(_ sender: Any) {
        let popUpVC = UIStoryboard(name: "Projects", bundle: nil).instantiateViewController(withIdentifier: "newProjectPopUpID") as! NewProjectPopUpViewController
        self.addChildViewController(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
        
    }
    
}

