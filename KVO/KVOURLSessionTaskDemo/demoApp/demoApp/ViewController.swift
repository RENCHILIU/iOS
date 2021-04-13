//
//  ViewController.swift
//  demoApp
//
//  Created by liurenchi on 4/12/21.
//

import UIKit
private var requestTaskContext = 0

class ViewController: UIViewController {
  
  var requestTask: URLSessionTask?
  override func viewDidLoad() {
    super.viewDidLoad()

    requestTask = URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://www.apple.com")!)) { [weak self] (data, response, error)  in
      print("URLSession.shared.dataTask is excuting")
      print(self?.requestTask?.state.rawValue)
    }
    requestTask?.addObserver(self, forKeyPath: "state", options: [], context: &requestTaskContext)
    
    print(requestTask?.state.rawValue)
    requestTask?.resume()
    print(requestTask?.state.rawValue)

  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    guard context == &requestTaskContext else { return }
    
    if let object = object as? URLSessionTask {
      if object === self.requestTask && keyPath == "state" {
        print(" has change to --> \(object.state.rawValue)")
      }
    }
  }
  
}

