//
//  AddPersonVC.swift
//  PeopleAndTheCity
//
//  Created by Luna An on 3/23/17.
//  Copyright © 2017 Mimicatcodes. All rights reserved.
//

import UIKit
import NotificationCenter

class AddPersonVC: UIViewController {
        
    // MARK: Properties
    
    @IBOutlet weak var editInstructionLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var submitButton: CustomButton!
    
    var personToEdit: Person? = nil
    var activeTextField:UITextField?
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.autocapitalizationType = .words
        cityField.autocapitalizationType = .words
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.global().async {
            self.configureDataForEdit()
        }
        configureUITitles()
    }
    
    // MARK: Methods
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        guard let name = nameField.text, name != "" else {
            
            return }
        guard let city = cityField.text, city != "" else {
            
            return }
        
        if let person = personToEdit {
            let personWithNewInfo = Person(id: person.id, name: name, favoriteCity: city)
            DispatchQueue.main.async {
                ApiManager.sharedInstance.update(person: personWithNewInfo, completion: { (newPerson) in
                    NotificationCenter.default.post(name: NotificationName.refreshData, object: nil)
                    print("✓ ID: \(personWithNewInfo.id)")
                    print("✓ New name: \(personWithNewInfo.name)")
                    print("New ❤︎ city: \(personWithNewInfo.favoriteCity)")
                })
            }
        } else {
            let newPerson = Person(id: 0, name: name, favoriteCity: city)
            DispatchQueue.main.async {
                ApiManager.sharedInstance.add(person: newPerson, completion: { (json) in
                    print("Added \(json.description)")
                    NotificationCenter.default.post(name: NotificationName.refreshData, object: nil)
                })
            }
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
    
    func configureUITitles(){
        if personToEdit != nil {
            editInstructionLabel.isHidden = false
            submitButton.setTitle(ButtonTitle.save, for: .normal)
        } else {
            editInstructionLabel.isHidden = true
            submitButton.setTitle(ButtonTitle.submit, for: .normal)
        }
    }
}

extension AddPersonVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

