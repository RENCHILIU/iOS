//
//  ViewController.swift
//  demoApp
//
//  Created by liurenchi on 4/9/21.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Fetch the setting dictionary
    let defaults = UserDefaults.standard
    if let environmentDict = defaults.object(forKey: "ENV_URL") {
      print(environmentDict)
      /**
       {
           "ROOT_URL" = "http://renchiliu.com/perf";
           "URL_KEY" = PERF;
       }
       */
    }
  
  }


}

