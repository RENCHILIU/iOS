//
//  MyworkItemTest.swift
//  MultiThreadTests
//
//  Created by liurenchi on 1/10/22.
//

import XCTest
@testable import MultiThread

class MyworkItemTest: XCTestCase {
  
  let op = MyWorkGroup()
  
  func testWorkItem() {
    op.workItem()
  }
  
  func testGroupWorkAsyncWaiting() {
    op.groupWorkAsyncWaiting()
  }
  
  func testGroupWorkSyncWaiting() {
    op.groupWorkSyncWaiting()
    
    //The work will still working even the queue said it is timeout.
    /*
     A
     B
     C
     all jobs cannot be ececuted in time
     D
     */
  }
  
  func testGroupEnterLeave() {
    op.testGroupEnterLeave()
  }
  
  func testSemaphore() {
    op.testSemaphore()
    
    /*
     It gurantees only executing 2 at the same time.
     Number 2 job is done
     Number 1 job is done
     ======
     Number 3 job is done
     Number 4 job is done
     ======
     Number 5 job is done
     */
  }
}
