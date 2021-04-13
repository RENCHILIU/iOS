//
//  ViewController.swift
//  demoApp
//
//  Created by liurenchi on 4/12/21.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    testBlock()
    testBlock2()
    testMyOperationWithHandler()
  }
  
  
  func testBlock() {
    let block = BlockOperation {
      print("BlockOperation excuted")
    }
    OperationQueue.main.addOperation(block)
  }
  
  func testBlock2() {
    let block = MyOperation()
    OperationQueue.main.addOperation(block)
  }
  
  func testMyOperationWithHandler() {
    let block = MyOperationWithHandler()
    block.completionBlock = { print("completionBlock excuted")}
    block.myPersonalHandler = { print("myPersonalHandler excuted")}
    OperationQueue.main.addOperation(block)
  }
  
}
