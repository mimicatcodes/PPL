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
    
    var userLoggedIn: User? = nil // Assume that the user has logged in
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userLoggedIn = User(id: 1, name: "Sean", email: "xyz@gmail.com")
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        guard userLoggedIn != nil else { return }
        guard let name = nameField.text, name != "" else { return }
        guard let city = cityField.text, city != "" else { return }

        DispatchQueue.main.async {
            if let user = self.userLoggedIn {
                ApiManager.sharedInstance.addPerson(id: user.id, name: name, favoriteCity: city, completion: { (newPerson) in
                    
                // Do Something
                    
                })
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
