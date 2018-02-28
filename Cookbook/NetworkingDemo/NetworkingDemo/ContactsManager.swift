//
//  ContactsManager.swift
//  NetworkingDemo
//
//  Created by liurenchi on 2/24/18.
//  Copyright © 2018 lrc. All rights reserved.
//

import Foundation
import UIKit

typealias CompletionHandler = (_ success: Bool, _ contacts:[Contact]) -> ()


class ContactsManager: NSObject {
    
    func fetchContacts(page: Int, pageSize: Int, handler: @escaping CompletionHandler){
        let session = URLSession.shared
        let url = URL(string:"https://randomuser.me/api/?page=\(page)&results=\(pageSize)")
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if let error = error{
                print(error.localizedDescription)
            }else if let httpResponse = response as? HTTPURLResponse{
                var success = false
                var allContacs = [Contact]()
                if httpResponse.statusCode == 200{
                    if let responseData = data{
                        do{
                            let json = try
                            JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as! Dictionary<String, Any>
                            
                            let contacts = self.parseContactsJSON(json: json)
                            allContacs.append(contentsOf: contacts)
                            success = true
                        }
                        catch{
                            print(error)
                        }
                    }
                }
                handler(success,allContacs)
            }
        }
        dataTask.resume()
    }
    
    func parseContactsJSON(json: Dictionary<String, Any>) -> [Contact]{
        var contacts = [Contact]()
        if let contactsJson = json["results"] as? [Dictionary<String, Any>]{
            for contactObj in contactsJson{
                let contact = Contact(json: contactObj)
                contacts.append(contact)
            }
        }
        return contacts
    }
    
    
    
    
    
    
    
    

}
