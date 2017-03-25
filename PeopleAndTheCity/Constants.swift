//
//  Constants.swift
//  PeopleAndTheCity
//
//  Created by Mirim An on 3/23/17.
//  Copyright © 2017 Mimicatcodes. All rights reserved.
//

import Foundation

struct UrlForAPI {
    static let people = "https://gentle-ocean-61971.herokuapp.com/people"
    static let all = "https://gentle-ocean-61971.herokuapp.com/all"
    static let allOne = "https://gentle-ocean-61971.herokuapp.com/all/1"
    // TODO: Switch names for people and all
}

struct Identifier {
    struct Cell {
        static let personCell = "personCell"
    }
    
    struct Segue {
        static let toAddPerson = "toAddPerson"
    }
}