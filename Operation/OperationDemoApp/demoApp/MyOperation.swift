//
//  MyOperation.swift
//  demoApp
//
//  Created by liurenchi on 4/12/21.
//

import Foundation

class MyOperation: Operation {
  override func main() {
    print("main() excuted")
  }
}

class MyOperationWithHandler: Operation {
  /**
   by default the Operation has below completion after main function
   var completionBlock: (() -> Void)?
   */
  var myPersonalHandler: (() -> Void)?
  override func main() {
    print("main() excuted")
    myPersonalHandler?()
  }
}

/**
 If you are creating a concurrent operation, you need to override the following methods and properties at a minimum:
 
 start()
 
 isAsynchronous
 
 isExecuting
 
 isFinished
 */
class MyOperatio2: Operation {
  
  
}
