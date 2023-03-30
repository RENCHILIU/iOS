//
//  ViewController.swift
//  demoApp
//
//  Created by liurenchi on 4/13/21.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let request = URLRequest(url: URL(string: "https://reqres.in/api/users?page=2")!)
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      
      print(data)
      
      print(response)
      
      print(error)
      
      
      
    }
    
    task.resume()
    
    
  
  }



}

