# Modeling data with enums


# Table of contents

- [Modeling data with enums](#modeling-data-with-enums)
  - [Or vs. and](#or-vs-and)
  - [Enums for polymorphism](#enums-for-polymorphism)
  - [Enums instead of subclassing](#enums-instead-of-subclassing)
  - [Algebraic data types](#algebraic-data-types)
  - [A safer use of strings](#a-safer-use-of-strings)
  
  
## Or vs. and 

Enum is better than struct when we want to identify the unique model. like below :


1. Struct
```swift
struct Message {
    let userId: String
    let contents: String?
    let date: Date
    
    let hasJoined: Bool
    let hasLeft: Bool
    
    let isBeingDrafted: Bool
    let isSendingBalloons: Bool
}
```


2. Enum 
```swift
enum Message {
    case text(userId: String, contents: String, date: Date)
    case draft(userId: String, date: Date)
    case join(userId: String, date: Date)
    case leave(userId: String, date: Date)
    case balloon(userId: String, date: Date)
}
```

In here, the attributes of the struct Message are exclusive. only one from the 4 bool can be true. 
So we will consider to convert it to Enum. 




## Enums for polymorphism

Enum has the case matching , we can use it to parse the Any type in the run time.

 **Filling an array with multiple values + Matching on Any values at runtime**
```swift

let arr: [Any] = [Date(), "Why was six afraid of seven?", "Because...", 789]

for element: Any in arr {
  // element is "Any" type
  switch element {
    case let stringValue as String: "received a string: \(stringValue)"
    case let intValue as Int: "received an Int: \(intValue)"
    case let dateValue as Date: "received a date: \(dateValue)"
    default: print("I am not interested in this value")
  }
}
```


### Compile-time polymorphism
If you want to put some customized types into one group (most of time, they are related. ), you can create an Enum and **embed** the types into it as the cases.

```swift
// define model 
enum DateType {
  case singleDate(Date)
  case dateRange(Range<Date>)
}

// init
let now = Date()
let hourFromNow = Date(timeIntervalSinceNow: 3600)

let dates: [DateType] = [
    DateType.singleDate(now),
    DateType.dateRange(now..<hourFromNow)
]

// usage 
for dateType in dates {
    switch dateType {
    case .singleDate(let date): print("Date is \(date)")
    case .dateRange(let range): print("Range is \(range)")
    }
}
```

## Enums instead of subclassing

consdier we have below structs 
```swift
struct  Run {
	let id: String
	let  startTime: Date
	let endTime: Date
	let  distance: Float
	let  onRunningTrack: Bool
}

struct  Cycle {
	let id: String
	let  startTime: Date
	let endTime: Date
	let  distance: Float
	let incline: Int
	let type: CycleType
}
```

The first mind is to convert them to class and make them subclass from :
```swift
class  Workout {
	let id: String
	let  startTime: Date
	let endTime: Date
	let  distance: Float
}
```

**But**
When we want to introduce another new struct, such as Pushups. 
```swift
class Pushups: Workout {        
    let repetitions: [Int]
    let date: Date
}
```
We will end up to get the startTime, endTime, distance from superclass which we don't need.
If we consist to have this approach , we need to refactor Workout and move properties out.

### Refactoring a data model with enums

Consider if Workout is Enum 
```swift
enum Workout {
    case run(Run)
    case cycle(Cycle)
    case pushups(Pushups)
}
```

Now the workout can have any types in its case.  (it kind of has the dynamic language features)
```swift
// usage
let pushups = Pushups(repetitions: [22,20,10], date: Date())
let workout = Workout.pushups(pushups)

// introduce more category
enum Workout {
    case run(Run)
    case cycle(Cycle)
    case pushups(Pushups)
    case abs(Abs) //new type without worry about touching Workout.              
 }
```

How to make the decision between **Subclass** vs. **Enum** 

| Subclass |Enum  |
|--|--|
|rigid hierarchy  | loose |
|no need to match all types|need to match all types in Enum|
|you subclass as customers|unless you own the code, you have to touch the origin|


## Algebraic data types


Algebraic data types commonly express composed data via something called sum types and product types.


### Sum types
```swift
enum Day {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}

// the total sum is seven

// UInt8 is  an Enum from 0-256

enum Age {
  case known(UInt8)
  case unknown
}
//Age  now represents 257 possible values, namely, the unknown case(1) + known case(256).
```
### Product types
A product type multiplies the possible values it contains.

```swift
struct BooleanContainer {
  let first: Bool
  let second: Bool
}
//The first Boolean (two possible values) _times_ the second Boolean (two possible values) is four possible states that this struct may have.
```

## A safer use of strings

**[RISK]** directly using Enum rawValue 
```swift
let parameters = ["filter": currency.rawValue]

//be careful with rawVale when using String. as changes in rawValue could impact code.  we lose the Enum type checking.
```

**[GREEN]** better approach

```swift
let parameters: [String: String]
switch currency {
    case .euro: parameters = ["filter": "euro"]
    case .usd: parameters = ["filter": "usd"]
    case .gbp: parameters = ["filter": "gbp"]
}

// Back to using "euro" again
print(parameters) // ["filter": "euro"]
// even we changed the rawValue of Currency, the changes wouldn't FW to this parameters.  in here we are not using rawValue directly , we still use the Enum type which has the swift type checking benefit.
```

### Matching on strings

```swift
func iconName(for fileExtension: String) -> String {
    switch fileExtension {
    case "jpg": return "assetIconJpeg"
    case "bmp": return "assetIconBitmap"
    case "gif": return "assetIconGif"
    default: return "assetIconUnknown"
    }
}

enum ImageType: String {   
  case jpg
  case bmp
  case gif
}

func iconName(for fileExtension: String) -> String {
    guard let imageType = ImageType(rawValue: fileExtension) else {
        return "assetIconUnknown"                                   
    }
    switch imageType {                                            
    case .jpg: return "assetIconJpeg"
    case .bmp: return "assetIconBitmap"
    case .gif: return "assetIconGif"
    }
}

//instead of using rawValue to match the String(could introducec typo), it will be better to have Enum with String type. 

enum ImageType: String {
    case jpg
    case bmp
    case gif

    init?(rawValue: String) {
        switch rawValue.lowercased() {       
        case "jpg", "jpeg": self = .jpg      
        case "bmp", "bitmap": self = .bmp
        case "gif", "gifv": self = .gif
        default: return nil
        }
    }
// in the initializing , we can extend the raw String .
}
```





---

reading notes from https://swiftindepth.com/
