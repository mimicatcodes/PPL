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
    
    // MARK: Properties

    @IBOutlet weak var tableView: UITableView!
    
    var persons: [Person]?
    var personToEdit: Person?
    
    let refresher = UIRefreshControl()
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPersons()
        refreshControl()
        tableView.separatorStyle = .none
        configureEmptyState()
        NotificationCenter.default.addObserver(forName: NotificationName.refreshData, object: nil, queue: nil) { (notification) in
            DispatchQueue.main.async {
                self.getPersons()
            }
        }
    }
    
    // MARK: Refresh Control

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
    
    // MARK: Empty State
    
    func configureEmptyState(){
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = EmptyState.title
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = EmptyState.description
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    // MARK: Swipe Actions
    
    func configureSwipeButtons(cell:PersonCell, indexPath: IndexPath){
        
        // height 102
        
        let deleteButton = MGSwipeButton(title: ButtonTitle.delete, icon: UIImage(named:""), backgroundColor: UIColor.black) { (sender: MGSwipeTableCell) -> Bool in
            self.alertForDelete(indexPath: indexPath)
            return true
        }
        
        let editButton = MGSwipeButton(title: ButtonTitle.edit, icon: UIImage(named:""), backgroundColor: UIColor.gray)  { (sender: MGSwipeTableCell) -> Bool in
            DispatchQueue.global().async {
                self.personToEdit = self.persons?[indexPath.row]
                if let person = self.personToEdit {
                    print("✓ ID: \(person.id)")
                    print("✓ Name to edit: \(person.name)")
                    print("❤︎ city to edit: \(person.favoriteCity)")
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: Identifier.Segue.toAddPerson, sender: self)
                    }
                }
            }
            return true
        }
        cell.rightButtons = [deleteButton, editButton]
        cell.rightExpansion.buttonIndex = 0
    }
    
    func alertForDelete(indexPath: IndexPath){
        let alertController = UIAlertController(title: Message.deleteTitle,  message: Message.deleteDescription, preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: ButtonTitle.delete, style: .default, handler: { action in
            let selectedPerson = self.persons?[indexPath.row]
            if let person = selectedPerson {
                ApiManager.sharedInstance.delete(person: person, completion: { (success) in
                    print("Deleted id:\(person.id), name:\(person.name), favorite city: \(person.favoriteCity) from the server")
                        self.getPersons()
                })
            }
        })
        
        let cancelAction = UIAlertAction(title: ButtonTitle.cancel, style: .cancel) { action in
            print("Cancel tapped")
        }
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    // MARK: Segue Method
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifier.Segue.toAddPerson {
            let dest = segue.destination as! AddPersonVC
            dest.personToEdit = personToEdit
        }
    }
    
    // MARK: API Method

    func getPersons() {
        ApiManager.sharedInstance.getPersons(completion: { (persons) in
            self.persons = persons.sorted(by: { (person1, person2) -> Bool in
                person1.id < person2.id
            })
            self.tableView.reloadData()
        })
    }
}

    // MARK: Table View

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
