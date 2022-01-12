//
//  testOperation.swift
//  MultiThread
//
//  Created by liurenchi on 1/8/22.
//

import Foundation

class MyQueue {
  
  func testSyncSerial() {
    print("======testSyncSerial======")
    DispatchQueue.global().sync {
      let myqueue = DispatchQueue(label: "myQueue")
      myqueue.sync { Utilty.printHelper(number: 1) }
      print("a")
      myqueue.sync { Utilty.printHelper(number: 2) }
      print("b")
      myqueue.sync { Utilty.printHelper(number: 3) }
      print("c")
      myqueue.sync { Utilty.printHelper(number: 4)}
      print("d")
      print("======END======")
    }
  }

  
  func testAsyncSerial() {
    print("======testAsyncSerial======")
    DispatchQueue.global().sync {
      let myqueue = DispatchQueue(label: "myQueue")
      myqueue.async { Utilty.printHelper(number: 1) }
      print("a")
      myqueue.async { Utilty.printHelper(number: 2) }
      print("b")
      myqueue.async { Utilty.printHelper(number: 3) }
      print("c")
      myqueue.async { Utilty.printHelper(number: 4) }
      print("d")
      myqueue.sync { sleep(UInt32(40))
        print("======END======")
      }
    }
  }
  
  func testSyncConcurrent() {
    print("======testSyncConcurrent======")
    let myqueue = DispatchQueue(label: "myConcurrentQueue", attributes: .concurrent)
    myqueue.sync { Utilty.printHelper(number: 1) }
    print("a")
    myqueue.sync { Utilty.printHelper(number: 2) }
    print("b")
    myqueue.sync { Utilty.printHelper(number: 3) }
    print("c")
    myqueue.sync { Utilty.printHelper(number: 4) }
    print("d")
    print("======END======")
  }
  
  
  
  func testAsyncConcurrent() {
    print("======testAsyncConcurrent======")
    let myqueue = DispatchQueue(label: "myConcurrentQueue", attributes: .concurrent)
    myqueue.async { Utilty.printHelper(number: 1) }
    print("a")
    myqueue.async { Utilty.printHelper(number: 2) }
    print("b")
    myqueue.async { Utilty.printHelper(number: 3) }
    print("c")
    myqueue.async { Utilty.printHelper(number: 4) }
    print("d")
    myqueue.sync { sleep(UInt32(40))
      print("======END======")
    }
  }
    
  
  func testSyncConcurrent2() {
    print("======testSyncConcurrent2======")
    let myqueue = DispatchQueue(label: "myConcurrentQueue", attributes: .concurrent)
    myqueue.sync { Utilty.printHelper(number: 1) }
    DispatchQueue.global().sync{ print("a") }
    myqueue.sync { Utilty.printHelper(number: 2) }
    DispatchQueue.global().sync{ print("b") }
    myqueue.sync { Utilty.printHelper(number: 3) }
    DispatchQueue.global().sync{ print("c") }
    myqueue.sync { Utilty.printHelper(number: 4) }
    DispatchQueue.global().sync{ print("d") }
    print("======END======")
  }
  
  func testSyncAsyncConcurrent() {
    print("======testSyncAsyncConcurrent======")
    let myqueue = DispatchQueue(label: "myConcurrentQueue", attributes: .concurrent)
    myqueue.sync { Utilty.printHelper(number: 1) }
    print("a")
    myqueue.async { Utilty.printHelper(number: 2) }
    print("b")
    myqueue.sync { Utilty.printHelper(number: 3) }
    print("c")
    myqueue.sync { Utilty.printHelper(number: 4) }
    print("d")
    print("======END======")
  }
  
  func testSyncAsyncSerial() {
    /*
     A Dispatch serial queue guarantees that only one thread will being executing work on the queue at a time. It does not guarantee which specific thread will do that execution. Dispatch maintains a pool of worker threads and, when work becomes available to execute, it will allocate one thread from that pool to run that work.

     One consequence of this is that it’s not safe to use thread-local storage in code run from a serial queue. If you have data you want to associate with the queue, you should use
     */
    print("======testSyncAsyncSerial======")
    DispatchQueue.global().sync {
      let myqueue = DispatchQueue(label: "myQueue")
      myqueue.sync { Utilty.printHelper(number: 1) }
      print("a")
      myqueue.async { Utilty.printHelper(number: 2) }
      print("b")
      myqueue.async { Utilty.printHelper(number: 3) }
      print("c")
      myqueue.sync { Utilty.printHelper(number: 4)}
      print("d")
      print("======END======")
    }
  }
  
  func testSyncAsyncSerialThreadSafe() {
    
    print("======testSyncAsyncSerialThreadSafe======")
    DispatchQueue.global().sync {
      let myqueue = DispatchQueue(label: "myQueue")
      myqueue.sync { Utilty.addHelper()  }
      print("a")
      myqueue.async { Utilty.addHelper()  }
      print("b")
      myqueue.async { Utilty.addHelper() }
      print("c")
      myqueue.sync { Utilty.addHelper() }
      print("d")
      print(Utilty.countValue)
      print("======END======")
    }
  }
  
  func testSyncAsyncSerialThreadSafe2() {
    
    print("======testSyncAsyncSerialThreadSafe2======")
    DispatchQueue.global().sync {
      let myqueue = DispatchQueue(label: "myQueue")
      myqueue.sync { Utilty.addHelper()  }
      print("a")
      DispatchQueue.global().async { Utilty.addHelper()  }
      print("b")
      DispatchQueue.global().async { Utilty.addHelper() }
      print("c")
      myqueue.sync { Utilty.addHelper() }
      print("d")
      print(Utilty.countValue)
      
      DispatchQueue.global().async { sleep(UInt32(40))
        print("======END======")
      }
    }
  }
  
}
