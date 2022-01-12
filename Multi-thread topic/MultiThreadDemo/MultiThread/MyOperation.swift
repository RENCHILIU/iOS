//
//  MyOperation.swift
//  MultiThread
//
//  Created by liurenchi on 1/11/22.
//

import Foundation

class MyOperation {
  
  func testBlockOperation() {
    let myBlockOp = BlockOperation()
    
    let sentence = "I love apple"
    
    sentence.split(separator: " ").forEach { (sub) in
      myBlockOp.addExecutionBlock {
        print(sub)
      }
    }
    myBlockOp.start()
  }
  
  func testBlockOperation2() {
    let myBlockOp = BlockOperation()
    
    let sentence = "I love apple"
    
    sentence.split(separator: " ").forEach { (sub) in
      myBlockOp.addExecutionBlock {
        sleep(2)
        print(sub)
      }
    }
    myBlockOp.start()
  }
  
  func testBlockOperationWithCompletion() {
    let myBlockOp = BlockOperation()
    
    let sentence = "I love apple"
    
    sentence.split(separator: " ").forEach { (sub) in
      myBlockOp.addExecutionBlock {
        sleep(2)
        print(sub)
      }
    }
    
    myBlockOp.completionBlock = {
      print("the op is finished !")
    }
    myBlockOp.start()
  }
  
}
