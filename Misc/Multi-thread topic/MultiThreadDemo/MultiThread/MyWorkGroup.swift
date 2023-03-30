//
//  MyWorkGroup.swift
//  MultiThread
//
//  Created by liurenchi on 1/10/22.
//

import Foundation

class MyWorkGroup {
  
  func workItem() {
    let workItem = DispatchWorkItem {
      print("This is a workItem")
    }
    DispatchQueue.global(qos: .userInitiated).async(execute: workItem)
    
  }
  
  func groupWorkAsyncWaiting() {
    
    let myGroup = DispatchGroup()
    
    let myQueue = DispatchQueue(label: "myQueue")
    myQueue.async(group: myGroup, execute: DispatchWorkItem(block: {print("A")}))
    myQueue.async(group: myGroup, execute: DispatchWorkItem(block: {print("B")}))
    myQueue.async(group: myGroup, execute: DispatchWorkItem(block: {print("C")}))
    myQueue.async(group: myGroup, execute: DispatchWorkItem(block: {print("D")}))
    
    // Async waiting
    myGroup.notify(queue: DispatchQueue.main, work: DispatchWorkItem(block: {
      print("I have ABCD!")
    }))
    
  }
  
  func groupWorkSyncWaiting() {
    
    let myGroup = DispatchGroup()
    
    let myQueue = DispatchQueue(label: "myQueue")
    myQueue.async(group: myGroup, execute: DispatchWorkItem(block: {
                                                                print("A")}))
    myQueue.async(group: myGroup, execute: DispatchWorkItem(block: {print("B")}))
    myQueue.async(group: myGroup, execute: DispatchWorkItem(block: {print("C")}))
    myQueue.async(group: myGroup, execute: DispatchWorkItem(block: {
                                                                sleep(14)
                                                                print("D")}))
    
    //This is a synchronous method that will block the current queue
    // never ever call wait on the main queue.
    if myGroup.wait(timeout: .now() + 12) == .timedOut {
      print("all jobs cannot be ececuted in time")
    } else {
      print("I have ABCD!")
    }
    
    sleep(3) // D will return even timeout
  }
  
  
  func testGroupEnterLeave() {
    let myGroup = DispatchGroup()
    
    myGroup.enter()
    DispatchQueue.global(qos: .userInitiated).async {
      print("A job start")
      sleep(10) // could be network call or heavy duty
      
      DispatchQueue.main.async {
        print("A completion handler")
        myGroup.leave()
      }
    }
    
    myGroup.enter()
    DispatchQueue.global(qos: .userInitiated).async {
      print("B job start")
      sleep(2) // could be network call or heavy duty
      
      DispatchQueue.main.async {
        print("B completion handler")
        myGroup.leave()
      }
    }
    // we can also use defer for leave()
    
    myGroup.notify(queue: DispatchQueue.main) {
      print("all jobs end")
    }
    
    sleep(12)
  }
  
  
  func testSemaphore() {
    let mySemaphore = DispatchSemaphore(value: 2)
    
    for i in 1...5 {
      mySemaphore.wait()

      DispatchQueue.global(qos: .userInitiated).async {
        defer {
          mySemaphore.signal()
        }
        sleep(2)
        print("Number \(i) job is done")
      }
    }
    
    sleep(10)
  }
}
