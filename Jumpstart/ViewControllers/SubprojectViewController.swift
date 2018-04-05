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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
        
        setWritingStages()
        setProjectDeadline()
        setProjectProgress()
        setSubprojectNavBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = .jBlue
        self.navigationController?.navigationBar.backgroundColor = .jBlue
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
  
    //MARK: TableView Delegate and Datasource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let subProjectArray = specificProject?.subProjects
        return (subProjectArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let subProjectArray = specificProject?.subProjects
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProjectTableViewCell
        //set title
        cell.progressTitle.text = subProjectArray![indexPath.row].title
        cell.progressTitle.textColor = UIColor.black
        
        //set date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        cell.progressDeadline.text = subProjectArray![indexPath.row].deadline
        
        //set progress circle
        cell.progressCircle.innerRingColor = UIColor.jGreen
        cell.progressCircle.value = CGFloat(subProjectArray![indexPath.row].progress!)
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
        self.addChildViewController(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}