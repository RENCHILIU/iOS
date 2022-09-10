## Writing cleaner properties

take a normal struct as an example 
```swift
import Foundation

struct Run {
    let id: String
    let startTime: Date
    var endTime: Date?

    func elapsedTime() -> TimeInterval {             
         return Date().timeIntervalSince(startTime)
    }

    func isFinished() -> Bool {                      
         return endTime !=  nil
    }

    mutating func setFinished() {
        endTime = Date()
    }

    init(id: String, startTime: Date) {
        self.id = id
        self.startTime = startTime
        self.endTime = nil
    }
}
```

```swift
/*
 lack of parameters and the fact that the functions return a value show that these functions are candidates for computed properties.
*/
func isFinished() -> Bool { ... }
func elapsedTime() -> TimeInterval { ... }

var elapsedTime: TimeInterval {                  
         return Date().timeIntervalSince(startTime)
    }

var isFinished: Bool {                           
        return endTime !=  nil
    }
```
by converting the func to the computed properties. we hide the computing logic and let customer to use it with unawareness.

## Lazy properties

For the expensive compution , we will use the lazy properties. 
Lazy properties are calculated at a later time (if at all) and only once.

### Using lazy properties
**compute & store**
Lazy properties will compute and store the value. so we don't need to init it in the init() , the compution will rely on some other store properties . 



### Making a lazy property robust
**protect the lazy properties**

```swift 
lazy private(set) xxx > lazy private xxx
// by adding private(set), we don't allow lazy properties to be reassigned.
```

### Mutable properties and lazy properties
once the lazy properties been called, that moment it will be initialized. 
**[RISK]** so even other store properties changed, the lazy properties which relied on them would change its value anymore.
**[RISK]** Then same when you copy the struct after lazy properties been called/initialized. 

```swift
var intensePlan = LearningPlan(level: 138, description: "A special plan for
     today!")
print(intensePlan.contents)         
var easyPlan = intensePlan          
easyPlan.level = 0                  
print(easyPlan.contents)  // in here, the print will be the same as  intensePlan.contents 


var intensePlan = LearningPlan(level: 138, description: "A special plan for
     today!")
// we don't call this line. print(intensePlan.contents)         
var easyPlan = intensePlan          
easyPlan.level = 0                  
print(easyPlan.contents)  // in here, the print will be easyPlan's own 

```

## Property observers

using defer , we can add observers in the init() for our store properties . 

```swift
init(id: String, name: String) {
	self.id = id
	self.name = name
}

// convert to 
init(id: String, name: String) {
	defer {self.name = name}
	self.id = id
	self.name = name
}
```






