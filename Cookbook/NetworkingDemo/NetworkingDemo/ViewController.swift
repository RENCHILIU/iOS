//
//  ViewController.swift
//  NetworkingDemo
//
//  Created by liurenchi on 2/24/18.
//  Copyright © 2018 lrc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var contacts = [Contact]()
    var currentPageIndex = 0
    let pageSize = 10
    var noMorePages = false
    var loadingPage = false
    
    
    @IBOutlet var contactsTableView: UITableView!
    @IBOutlet var connectButton: UIButton!
    //    @IBAction func didClickOnConnectButton(_ sender: Any) {
    //        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    //        let contactManager = ContactsManager()
    //        self.connectButton.setTitle("Connecting....", for: .normal)
    //        self.connectButton.isEnabled = false
    //        contactManager.fetchContacts { (sucess) in
    //            DispatchQueue.main.sync {
    //                UIApplication.shared.isNetworkActivityIndicatorVisible = false
    //                print(sucess)
    //                self.connectButton.setTitle("Finishing connection", for: .normal)
    //            }
    //        }
    //  }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNextPage()
    }
    func loadNextPage(){
        if noMorePages || loadingPage{
            return
        }
        loadingPage = true
        UIApplication.shared.isNetworkActivityIndicatorVisible =
        true
        let contactsManager = ContactsManager()
        contactsManager.fetchContacts(page: currentPageIndex,
                                      pageSize: pageSize) { (success, newContacts) in
                                        
                                        DispatchQueue.main.async {
                                            
                                            UIApplication.shared
                                                .isNetworkActivityIndicatorVisible = false
                                            
                                            self.loadingPage = false
                                            if success{
                                                if newContacts.isEmpty{
                                                    self.noMorePages = true
                                                }
                                                else{
                                                    self.contacts
                                                        .append(contentsOf: newContacts)
                                                    self.contactsTableView.reloadData()
                                                    self.currentPageIndex += 1
                                                }
                                            }
                                            
                                        }
        }
    }
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contact")
        let contact = self.contacts[indexPath.row]
        cell?.textLabel?.text = "\(contact.title) \(contact.firstName) \(contact.lastName)"
        return cell!
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, willDisplay
        cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.contacts.count - 1{
            loadNextPage()
        }
    }
}
