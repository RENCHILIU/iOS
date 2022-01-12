//
//  MultiThreadTests.swift
//  MultiThreadTests
//
//  Created by liurenchi on 1/8/22.
//

import XCTest
@testable import MultiThread

class MyQueueTests: XCTestCase {
  let op = MyQueue()
  //    override func setUpWithError() throws {
  //        // Put setup code here. This method is called before the invocation of each test method in the class.
  //    }
  //
  //    override func tearDownWithError() throws {
  //        // Put teardown code here. This method is called after the invocation of each test method in the class.
  //    }
  
  func testSyncSerial() {
    op.testSyncSerial()
  }
  
  func testAsyncSerial() {
    op.testAsyncSerial()
  }
  
  func testSyncConcurrent() {
    op.testSyncConcurrent()
  }
  
  func testSyncConcurrent2() {
    op.testSyncConcurrent2()
  }
  
  func testSyncAsyncConcurrent() {
    op.testSyncAsyncConcurrent()
  }
  
  func testSyncAsyncSerial() {
    op.testSyncAsyncSerial()
    
  }
  
  func testAsyncConcurrent() {
    op.testAsyncConcurrent()
  }
  
  func testSyncAsyncSerialThreadSafe() {
    op.testSyncAsyncSerialThreadSafe()
  }
  
  func testSyncAsyncSerialThreadSafe2() {
    op.testSyncAsyncSerialThreadSafe2()
  }
  
  //
  //    func testPerformanceExample() throws {
  //        // This is an example of a performance test case.
  //        self.measure {
  //            // Put the code you want to measure the time of here.
  //        }
  //    }
  
}
