//
//  ViewController.swift
//  PeopleAndTheCity
//
//  Created by Luna An on 3/21/17.
//  Copyright © 2017 Mimicatcodes. All rights reserved.
//

import UIKit
import MGSwipeTableCell
import NotificationCenter

var dataCache = NSCache<AnyObject, AnyObject>()

//TODO: use cache to retrieve data fast - setObject

class MainViewController: UIViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{
    
    var persons: [Person]?
    var personToEdit: Person?
    
    let refresher = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*if let font = UIFont(name: Fonts.montserratSemiBold, size: 16) {
            print("-----------------------------------")
            navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font,  NSForegroundColorAttributeName: UIColor.white]
        }

        navigationController?.navigationBar.barTintColor = Colors.tealish
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.layer.borderColor = UIColor.clear.cgColor
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()*/
        
        getPersons()

        refreshControl()
        tableView.separatorStyle = .none
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("refreshData"), object: nil, queue: nil) { (notification) in
            DispatchQueue.main.async {
                self.getPersons()
            }
        }
    }
    
    @IBAction func addPersonButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    func refreshControl(){
        if #available (iOS 10.0, *) {
            tableView.refreshControl = refresher
        } else {
            tableView.addSubview(refresher)
        }
        
        refresher.tintColor = UIColor.black
        refresher.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
    }
    
    func refreshTableView(){
        getPersons()
        refresher.endRefreshing()
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No data available yet."
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Please add your name and favorite city!"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func configureSwipeButtons(cell:PersonCell, indexPath: IndexPath){
        
        // height 102
        
        let deleteButton = MGSwipeButton(title: "Delete", icon: UIImage(named:""), backgroundColor: UIColor.black) { (sender: MGSwipeTableCell) -> Bool in
            self.alertForDelete(indexPath: indexPath)
            return true
        }
        
        let editButton = MGSwipeButton(title: "Edit", icon: UIImage(named:""), backgroundColor: UIColor.gray)  { (sender: MGSwipeTableCell) -> Bool in
            DispatchQueue.global().async {
                self.personToEdit = self.persons?[indexPath.row]
                print(self.personToEdit?.name ?? "Sean")
                print(self.personToEdit?.favoriteCity ?? "Brooklyn")
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: Identifier.Segue.toAddPerson, sender: self)
                }
            }
            print("Edit button tapped")
            return true
        }
        
        cell.rightButtons = [deleteButton, editButton]
        cell.rightExpansion.buttonIndex = 0
    }
    
    
    func alertForDelete(indexPath: IndexPath){
        let alertController = UIAlertController(title: "Are you sure you want to delete this data?",  message: "This action cannot be undone.", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default, handler: { action in
            let selectedPerson = self.persons?[indexPath.row]
            
            ApiManager.sharedInstance.delete(person: selectedPerson!, completion: { (success) in
                self.getPersons()
            })
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
        }
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifier.Segue.toAddPerson {
            let dest = segue.destination as! AddPersonVC
            dest.personToEdit = personToEdit
        }
    }
    
    func getPersons() {
        ApiManager.sharedInstance.getPersons(completion: { (persons) in
            self.persons = persons.sorted(by: { (person1, person2) -> Bool in
                person1.name < person2.name
            })
            self.tableView.reloadData()
        })
    }
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let persons = persons {
            return persons.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.Cell.personCell, for: indexPath) as! PersonCell
        cell.selectionStyle = .none
        cell.person = persons?[indexPath.row]
        configureSwipeButtons(cell: cell, indexPath: indexPath)
        return cell
    }
    
}
