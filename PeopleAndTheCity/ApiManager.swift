//
//  ApiManager.swift
//  PeopleAndTheCity
//
//  Created by Luna An on 3/23/17.
//  Copyright © 2017 Mimicatcodes. All rights reserved.
//

import UIKit

typealias JSON = [String: Any]
typealias ServiceResponse = (JSON, NSError?) -> Void

class ApiManager: NSObject {
    
    static let sharedInstance = ApiManager()
    
    func getPersons(completion: @escaping ([Person]) -> Void) {
        let baseUrlString = UrlForAPI.all
        
        guard let url = URL(string:baseUrlString) else {
            print("Error occured - No URL found")
            return }
        
        let session = URLSession.shared
        let request = URLRequest(url:url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Error downloading JSON")
            }
            
            guard let data_ = data else {
                print("No data")
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data_, options: [])
                var persons: [Person] = []
                
                for person in json as! [JSON] {
                    let newPerson = Person(json: person)
                    persons.append(newPerson)
                }
                DispatchQueue.main.async {
                    completion(persons)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func addPerson(id: Int, name: String, favoriteCity: String, completion: @escaping (JSON) -> Void) {
        
        let baseUrlString = UrlForAPI.people
        
        guard let url = URL(string:baseUrlString) else {
            print("Error occured - No URL found")
            return }
        
        let session = URLSession.shared
        var request = URLRequest(url:url)
        
        let newPerson = ["name": name, "favoritecity": favoriteCity] as [String : Any]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: newPerson, options: []) {
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                guard let data = data else {
                    print(error?.localizedDescription ?? "Error occured while posting JSON to the server")
                    return
                }
                
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSON else { return }
                    
                    DispatchQueue.main.async {
                        completion(json)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            })
            task.resume()
        }
        print("Unale to create jsonData")
    }
}
