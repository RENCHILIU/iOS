//
//  Utilty.swift
//  MultiThread
//
//  Created by liurenchi on 1/10/22.
//

import Foundation

struct Utilty {
  
  static var countValue: Int = 0
  
  static func addHelper() {
    print("About to add on for \(self.countValue) in\(Thread.current)")
    let waitingTime = Double.random(in: 0.0...10.0)
    Thread.sleep(forTimeInterval: waitingTime)
    self.countValue = self.countValue + 1
    print(String(format: "After wait %.2f s, value is: %d",waitingTime, self.countValue))
  }
  
  static func printHelper(number: Int) {
    print("About to print\(number) in\(Thread.current)")
    let waitingTime = Double.random(in: 0.0...10.0)
    Thread.sleep(forTimeInterval: waitingTime)
    print(String(format: "After wait %.2f s, printed: %d",waitingTime, number))
  }
}
