//
//  User.swift
//  PeopleAndTheCity
//
//  Created by Mirim An on 3/23/17.
//  Copyright © 2017 Mimicatcodes. All rights reserved.
//

import Foundation

struct User {
    var id: Int
    var name: String
    var email: String
    
    init(id: Int, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
}
