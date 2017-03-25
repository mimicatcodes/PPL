//
//  AddPersonVC.swift
//  PeopleAndTheCity
//
//  Created by Luna An on 3/23/17.
//  Copyright © 2017 Mimicatcodes. All rights reserved.
//

import UIKit

class AddPersonVC: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    
    var personToEdit: Person? = nil
   // var userLoggedIn: User? = nil // Assume that the user has logged in
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //userLoggedIn = User(id: 1, name: "Sean", email: "xyz@gmail.com")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.global().async {
            self.configureDataForEdit()
        }
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        //guard userLoggedIn != nil else { return }
        guard let name = nameField.text, name != "" else { return }
        guard let city = cityField.text, city != "" else { return }
        
        if let person = personToEdit {
            let personWithNewInfo = Person(id: person.id, name: name, favoriteCity: city)
            DispatchQueue.main.async {
                ApiManager.sharedInstance.update(person: personWithNewInfo, completion: { (newPerson) in
                    print("--------------------------EDIT TAPPED<3")
                    print("💋")
                    print(personWithNewInfo.favoriteCity)
                    print("💋")
                })
            }
            
        } else {
            let newPerson = Person(id: 0, name: name, favoriteCity: city)
            DispatchQueue.main.async {
                //if let user = self.userLoggedIn {
                    ApiManager.sharedInstance.add(person: newPerson, completion: { (json) in
                        //
                    })
                    /*
                    ApiManager.sharedInstance.add(person: newPerson, completion: { (newPerson) in
                        
                        // Do Something
                        
                    })*/
                }
            //}
        }
    
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func configureDataForEdit(){
        if let person = personToEdit {
            DispatchQueue.main.async {
                self.nameField.text = person.name
                self.cityField.text = person.favoriteCity
            }
        }
    }
}
