//
//  MyOperationTests.swift
//  MultiThreadTests
//
//  Created by liurenchi on 1/11/22.
//

import XCTest
@testable import MultiThread

class MyOperationTests: XCTestCase {
  let op = MyOperation()
  
  func testBlockOperation() {
    op.testBlockOperation()
    // the order is not gurantee as the BlockOperation is concurrency .
  }
  
  func testBlockOperation2() {
    op.testBlockOperation2()
  }
  
  func testBlockOperationWithCompletion() {
    op.testBlockOperationWithCompletion()
  }
  
  
}
