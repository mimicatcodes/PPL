//
//  ViewController.swift
//  PeopleAndTheCity
//
//  Created by Luna An on 3/21/17.
//  Copyright © 2017 Mimicatcodes. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var persons: [Person]?
    
    let refresher = UIRefreshControl()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl()
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPersons()
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
        tableView.reloadData()
        refresher.endRefreshing()
    }
    
    // GET request to /people
    func getPersons() {
        ApiManager.sharedInstance.getPersons(completion: { (persons) in
            self.persons = persons
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
        
        return cell
    }

}
