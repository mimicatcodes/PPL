//
//  Person.swift
//  PeopleAndTheCity
//
//  Created by Luna An on 3/23/17.
//  Copyright © 2017 Mimicatcodes. All rights reserved.
//

import Foundation

final class Person {
    var id: Int = 100
    var name: String
    var favoriteCity: String
    
    init(name: String, favoriteCity: String){
        self.name = name
        self.favoriteCity = favoriteCity
    }
    
    init(id: Int, name: String, favoriteCity: String) {
        self.id = id
        self.name = name
        self.favoriteCity = favoriteCity
    }
    
    init(json: JSON) {
        self.id = json["id"] as! Int
        self.name = json["name"] as! String
        self.favoriteCity = json["favoritecity"] as! String
    }
}
