//
//  ApiManager.swift
//  PeopleAndTheCity
//
//  Created by Luna An on 3/23/17.
//  Copyright © 2017 Mimicatcodes. All rights reserved.
//

import UIKit

typealias JSON = [String: Any]

class ApiManager: NSObject {
    
    static let sharedInstance = ApiManager()
    
    // MARK: GET METHOD
    func getPersons(completion: @escaping ([Person]) -> Void) {
        let baseUrlString = UrlForAPI.people
        
        guard let url = URL(string:baseUrlString) else {
            print(ErrorMessage.noUrl.rawValue)
            return }
        
        let session = URLSession.shared
        var request = URLRequest(url:url)
        request.addValue(Request.value, forHTTPHeaderField: Request.accept)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? ErrorMessage.retrievingError.rawValue)
            }
            
            guard let data_ = data else { return }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data_, options: []) as? [JSON] else { return }
                var persons: [Person] = []
                
                for person in json {
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
    
    // MARK: POST METHOD
    func add(person: Person, completion: @escaping (JSON) -> Void) {
        let baseUrlString = UrlForAPI.people
        
        guard let url = URL(string:baseUrlString) else {
            print(ErrorMessage.noUrl.rawValue)
            return }
        
        let session = URLSession.shared
        var request = URLRequest(url:url)
        
        let newPerson = [PersonKey.name: person.name, PersonKey.favoriteCity: person.favoriteCity] as [String : Any]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: newPerson, options: []) {
            request.httpMethod = HTTPMethod.post
            request.addValue(Request.value, forHTTPHeaderField: Request.headerKey)
            request.addValue(Request.value, forHTTPHeaderField: Request.accept)
            request.httpBody = jsonData
            
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                guard let data = data else {
                    print(error?.localizedDescription ?? ErrorMessage.uploadingError.rawValue)
                    return
                }
                
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON else { return }
                    
                    DispatchQueue.main.async {
                        completion(json)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            })
            task.resume()
        }
    }
    
    // MARK: PUT METHOD
    func update(person: Person, completion:@escaping (JSON) -> Void) {
        let baseUrlString = UrlForAPI.people + "/\(person.id)"
        
        guard let url = URL(string:baseUrlString) else {
            print(ErrorMessage.noUrl.rawValue)
            return
        }
        
        let session = URLSession.shared
        var request = URLRequest(url:url)
        
        let newInfo = [PersonKey.name: person.name, PersonKey.favoriteCity: person.favoriteCity] as JSON
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: newInfo, options: []) {
            request.httpMethod = HTTPMethod.put
            request.addValue(Request.value, forHTTPHeaderField: Request.headerKey)
            request.addValue(Request.value, forHTTPHeaderField: Request.accept)
            request.httpBody = jsonData
            
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                guard let data = data else {
                    print(error?.localizedDescription ?? ErrorMessage.updatingError.rawValue)
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
    }
    
    // MARK: DELETE METHOD
    func delete(person: Person, completion:@escaping () -> Void) {
        let baseUrlString = UrlForAPI.people + "/\(person.id)"
        
        guard let url = URL(string:baseUrlString) else {
            print(ErrorMessage.noUrl.rawValue)
            return }
        
        let session = URLSession.shared
        var request = URLRequest(url:url)
        request.httpMethod = HTTPMethod.delete
        request.addValue(Request.value, forHTTPHeaderField: Request.accept)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print(error?.localizedDescription ?? ErrorMessage.deletingError.rawValue)
            }
            
            guard let data = data else { return }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSON else { return }
                print(json)
                print("💋")
                DispatchQueue.main.async {
                    completion()
                }
            } catch {
                print(error.localizedDescription)
            }

        }
        task.resume()
    }
}


