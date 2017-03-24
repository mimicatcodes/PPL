//
//  PersonCell.swift
//  PeopleAndTheCity
//
//  Created by Luna An on 3/23/17.
//  Copyright © 2017 Mimicatcodes. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var person: Person? {
        didSet {
            nameLabel.text = person?.name
            cityLabel.text = person?.favoriteCity
        }
    }
}
