//
//  Constants.swift
//  PeopleAndTheCity
//
//  Created by Luna An on 3/23/17.
//  Copyright © 2017 Mimicatcodes. All rights reserved.
//

import Foundation
import NotificationCenter

struct PersonKey {
    static let name = "name"
    static let favoriteCity = "favoritecity"
    static let id = "id"
}

struct UrlForAPI {
    static let people = "https://gentle-ocean-61971.herokuapp.com/people"
    static let all = "https://gentle-ocean-61971.herokuapp.com/all"
}

struct Identifier {
    struct Cell {
        static let personCell = "personCell"
    }
    
    struct Segue {
        static let toAddPerson = "toAddPerson"
    }
}

struct NotificationName {
    static let refreshData =  NSNotification.Name("refreshData")
}

struct ButtonTitle {
    static let save = "Save"
    static let submit = "Submit"
    
    static let delete = "Delete"
    static let edit = "Edit"
    static let cancel = "Cancel"
}

struct HTTPMethod {
    static let get = "GET"
    static let post = "POST"
    static let put = "PUT"
    static let patch = "PATCH"
    static let delete = "DELETE"
}

struct Request {
    static let value = "application/json"
    static let headerKey = "Content-Type"
    static let accept = "Accept"
}

enum ErrorMessage : String, Error {
    case noUrl = "Error - No URL found"
    case retrievingError = "Error retrieving data from the server"
    case uploadingError = "Error uploading data to the server"
    case updatingError = "Error updating data to the server"
    case deletingError = "Error deleting data from the server"
}

struct EmptyState {
    static let title = "No data available yet"
    static let description = "Tap ' + ' to add data"
}

struct Message {
    static let deleteTitle = "Are you sure you want to delete this data?"
    static let deleteDescription = "This action cannot be undone."
}
