# Table of contents

- [Making optionals second nature](#making-optionals-second-nature)
  - [Clean optional unwrapping](#clean-optional-unwrapping)
  - [Variable shadowing](#variable-shadowing)
  - [When optionals are prohibited](#when-optionals-are-prohibited)
  - [Returning optional strings](#returning-optional-strings)
  - [Granular control over optionals](#granular-control-over-optionals)
  - [Falling back when an optional is nil](#falling-back-when-an-optional-is-nil)
  - [Simplifying optional enums](#simplifying-optional-enums)
  - [Chaining optionals](#chaining-optionals)
  - [Constraining optional Booleans](#constraining-optional-booleans)
  - [Force unwrapping guidelines](#force-unwrapping-guidelines)
  - [Taming implicitly unwrapped optionals](#taming-implicitly-unwrapped-optionals)

  
# Making optionals second nature

## Clean optional unwrapping

Optional are Enums type.  we can use it without syntax sugar and match it by Enum way.

```swift
struct Customer {
    let id: String
    let email: String
    let balance: Int
    let firstName: Optional<String>     
    let lastName: Optional<String>      
}

//  Matching on optional with syntactic sugar
switch customer.firstName {
 case let name?: print("First name is \(name)")           
 case nil: print("Customer didn't enter a first name")    
}
```
## Variable shadowing
```swift 

// we have 2 variables in here. which is shadowing
 if let lastName = lastName {                                  
      customDescription += " \(lastName)"       
  }
```

## When optionals are prohibited

### Adding a computed property
by introducing a computed property into the type. we will do the dirty work inside(un-wrapping). 


## Returning optional strings
**[RISK]**   `""` as return is not always a good idea for String . 
Soemtimes, if the string could be empty, we should return an optional String type instead of making it default as "".
It is more like the error handling , if you cannot hanle the case , it would be better to pass it to the place which can handle it . 


## Granular control over optionals

optional combine Enum will provide a Granular control when handling nil.
```swift
struct Customer {
    let id: String
    let email: String
    let firstName: String?
    let lastName: String?
    let balance: Int
    
    var displayName: String? {
        switch (firstName, lastName) {
        case let (first?, last?): return first + " " + last
        case let (first?, nil): return first
        case let (nil, last?): return last
        default: return nil
        }
    }
    
}
```

## Falling back when an optional is nil
```swift
let title: String = customer.displayName ?? "customer" // by using ??
```

## Simplifying optional enums

```swift 
enum Membership {
    /// 10% discount
    case gold
    /// 5% discount
    case silver
}

struct Customer {
    // ... snip
    let membership: Membership?
}

// Unwrapping an optional before pattern matching
if let membership = customer.membership {
    switch membership {
    case .gold: print("Customer gets 10% discount")
    case .silver: print("Customer gets 5% discount")
    }
} else {
    print("Customer pays regular price")
}

// !! a better way to do the Enum matching for nil
switch customer.membership {
case .gold?: print("Customer gets 10% discount")
case .silver?: print("Customer gets 5% discount")
case nil: print("Customer pays regular price")
}
```

## Chaining optionals

```swift

// approach 1
if let image = customer.favoriteProduct?.image {
  imageView.image = image
} else {
  imageView.image = UIImage(named: "missing_image")
}
// approach 2
imageView.image = customer.favoriteProduct?.image ?? UIImage(named: "missing_
     image")
```

## Constraining optional Booleans

nomally , when we deal with Boolean in swift . we have 3 outcomes: true/ false / nil.
by using ??, we can bind either ture/false when value is nil.

Another way is using **RawRepresentable** to handle.  as Enum's rawValue doesn;'t have boolean. 


```swift

//actually , the String and other Enum supported types are just the same .
enum UserPreference: RawRepresentable {          
    case enabled
    case disabled
    case notSet

    init(rawValue: Bool?) {                      
         switch rawValue {                       
           case true?: self = .enabled           
           case false?: self = .disabled         
           default: self = .notSet
         }
    }

    var rawValue: Bool? {                        
         switch self {
           case .enabled: return true
           case .disabled: return false
           case .notSet: return nil
         }
    }

}

// the same for other types .
```swift
enum Color {
    case red
    case green
    case blue
}
extension Color: RawRepresentable {
    typealias RawValue = UIColor

    init?(rawValue: RawValue) {
        switch rawValue {
        case UIColor.red: self = .red
        case UIColor.green: self = .green
        case UIColor.blue: self = .blue
        default: return nil
        }
    }

    var rawValue: RawValue {
        switch self {
        case .red: return UIColor.red
        case .green: return UIColor.green
        case .blue: return UIColor.blue
        }
    }
}
```

## Force unwrapping guidelines

Force unwrapping skip the checking , but it may lead crashes if value of optional type is nil. 

ideally, we should never use force unwrapper. unless below: 
|POSTPONING ERROR HANDLING | WHEN YOU KNOW BETTER THAN THE COMPILER |
|--|--|
|  "cheat yourself"| "has value for sure"  |

 


## Taming implicitly unwrapped optionals
Implicitly unwrapped optionals, or IUOs.

```swift
let lastName: String! = "Smith"      // IUO
 
let name: String? = 3
let firstName = name!                // force unwrapping
```
IUO is like a promise that we promise it will have value.  if that breaks, app will crash. 

**When do we truly need IUO ?**

IUO is like a double-edged sword.  we use it to avoid unwrapping everytime and skip the assignment in init() func. 
But, we need to take the risk of crash. (when the promise broken )

# Making optionals second nature

## Clean optional unwrapping

Optional are Enums type.  we can use it without syntax sugar and match it by Enum way.

```swift
struct Customer {
    let id: String
    let email: String
    let balance: Int
    let firstName: Optional<String>     
    let lastName: Optional<String>      
}

//  Matching on optional with syntactic sugar
switch customer.firstName {
 case let name?: print("First name is \(name)")           
 case nil: print("Customer didn't enter a first name")    
}
```
## Variable shadowing
```swift 

// we have 2 variables in here. which is shadowing
 if let lastName = lastName {                                  
      customDescription += " \(lastName)"       
  }
```

## When optionals are prohibited

### Adding a computed property
by introducing a computed property into the type. we will do the dirty work inside(un-wrapping). 


## Returning optional strings
**[RISK]**   `""` as return is not always a good idea for String . 
Soemtimes, if the string could be empty, we should return an optional String type instead of making it default as "".
It is more like the error handling , if you cannot hanle the case , it would be better to pass it to the place which can handle it . 


## Granular control over optionals

optional combine Enum will provide a Granular control when handling nil.
```swift
struct Customer {
    let id: String
    let email: String
    let firstName: String?
    let lastName: String?
    let balance: Int
    
    var displayName: String? {
        switch (firstName, lastName) {
        case let (first?, last?): return first + " " + last
        case let (first?, nil): return first
        case let (nil, last?): return last
        default: return nil
        }
    }
    
}
```

## Falling back when an optional is nil
```swift
let title: String = customer.displayName ?? "customer" // by using ??
```

## Simplifying optional enums

```swift 
enum Membership {
    /// 10% discount
    case gold
    /// 5% discount
    case silver
}

struct Customer {
    // ... snip
    let membership: Membership?
}

// Unwrapping an optional before pattern matching
if let membership = customer.membership {
    switch membership {
    case .gold: print("Customer gets 10% discount")
    case .silver: print("Customer gets 5% discount")
    }
} else {
    print("Customer pays regular price")
}

// !! a better way to do the Enum matching for nil
switch customer.membership {
case .gold?: print("Customer gets 10% discount")
case .silver?: print("Customer gets 5% discount")
case nil: print("Customer pays regular price")
}
```

## Chaining optionals

```swift

// approach 1
if let image = customer.favoriteProduct?.image {
  imageView.image = image
} else {
  imageView.image = UIImage(named: "missing_image")
}
// approach 2
imageView.image = customer.favoriteProduct?.image ?? UIImage(named: "missing_
     image")
```

## Constraining optional Booleans

nomally , when we deal with Boolean in swift . we have 3 outcomes: true/ false / nil.
by using ??, we can bind either ture/false when value is nil.

Another way is using **RawRepresentable** to handle.  as Enum's rawValue doesn;'t have boolean. 


```swift

//actually , the String and other Enum supported types are just the same .
enum UserPreference: RawRepresentable {          
    case enabled
    case disabled
    case notSet

    init(rawValue: Bool?) {                      
         switch rawValue {                       
           case true?: self = .enabled           
           case false?: self = .disabled         
           default: self = .notSet
         }
    }

    var rawValue: Bool? {                        
         switch self {
           case .enabled: return true
           case .disabled: return false
           case .notSet: return nil
         }
    }

}

// the same for other types .
```swift
enum Color {
    case red
    case green
    case blue
}
extension Color: RawRepresentable {
    typealias RawValue = UIColor

    init?(rawValue: RawValue) {
        switch rawValue {
        case UIColor.red: self = .red
        case UIColor.green: self = .green
        case UIColor.blue: self = .blue
        default: return nil
        }
    }

    var rawValue: RawValue {
        switch self {
        case .red: return UIColor.red
        case .green: return UIColor.green
        case .blue: return UIColor.blue
        }
    }
}
```

## Force unwrapping guidelines

Force unwrapping skip the checking , but it may lead crashes if value of optional type is nil. 

ideally, we should never use force unwrapper. unless below: 
|POSTPONING ERROR HANDLING | WHEN YOU KNOW BETTER THAN THE COMPILER |
|--|--|
|  "cheat yourself"| "has value for sure"  |

 


## Taming implicitly unwrapped optionals
Implicitly unwrapped optionals, or IUOs.

```swift
let lastName: String! = "Smith"      // IUO
 
let name: String? = 3
let firstName = name!                // force unwrapping
```
IUO is like a promise that we promise it will have value.  if that breaks, app will crash. 

**When do we truly need IUO ?**

IUO is like a double-edged sword.  we use it to avoid unwrapping everytime and skip the assignment in init() func. 
But, we need to take the risk of crash. (when the promise broken )

# Making optionals second nature

## Clean optional unwrapping

Optional are Enums type.  we can use it without syntax sugar and match it by Enum way.

```swift
struct Customer {
    let id: String
    let email: String
    let balance: Int
    let firstName: Optional<String>     
    let lastName: Optional<String>      
}

//  Matching on optional with syntactic sugar
switch customer.firstName {
 case let name?: print("First name is \(name)")           
 case nil: print("Customer didn't enter a first name")    
}
```
## Variable shadowing
```swift 

// we have 2 variables in here. which is shadowing
 if let lastName = lastName {                                  
      customDescription += " \(lastName)"       
  }
```

## When optionals are prohibited

### Adding a computed property
by introducing a computed property into the type. we will do the dirty work inside(un-wrapping). 


## Returning optional strings
**[RISK]**   `""` as return is not always a good idea for String . 
Soemtimes, if the string could be empty, we should return an optional String type instead of making it default as "".
It is more like the error handling , if you cannot hanle the case , it would be better to pass it to the place which can handle it . 


## Granular control over optionals

optional combine Enum will provide a Granular control when handling nil.
```swift
struct Customer {
    let id: String
    let email: String
    let firstName: String?
    let lastName: String?
    let balance: Int
    
    var displayName: String? {
        switch (firstName, lastName) {
        case let (first?, last?): return first + " " + last
        case let (first?, nil): return first
        case let (nil, last?): return last
        default: return nil
        }
    }
    
}
```

## Falling back when an optional is nil
```swift
let title: String = customer.displayName ?? "customer" // by using ??
```

## Simplifying optional enums

```swift 
enum Membership {
    /// 10% discount
    case gold
    /// 5% discount
    case silver
}

struct Customer {
    // ... snip
    let membership: Membership?
}

// Unwrapping an optional before pattern matching
if let membership = customer.membership {
    switch membership {
    case .gold: print("Customer gets 10% discount")
    case .silver: print("Customer gets 5% discount")
    }
} else {
    print("Customer pays regular price")
}

// !! a better way to do the Enum matching for nil
switch customer.membership {
case .gold?: print("Customer gets 10% discount")
case .silver?: print("Customer gets 5% discount")
case nil: print("Customer pays regular price")
}
```

## Chaining optionals

```swift

// approach 1
if let image = customer.favoriteProduct?.image {
  imageView.image = image
} else {
  imageView.image = UIImage(named: "missing_image")
}
// approach 2
imageView.image = customer.favoriteProduct?.image ?? UIImage(named: "missing_
     image")
```

## Constraining optional Booleans

nomally , when we deal with Boolean in swift . we have 3 outcomes: true/ false / nil.
by using ??, we can bind either ture/false when value is nil.

Another way is using **RawRepresentable** to handle.  as Enum's rawValue doesn;'t have boolean. 


```swift

//actually , the String and other Enum supported types are just the same .
enum UserPreference: RawRepresentable {          
    case enabled
    case disabled
    case notSet

    init(rawValue: Bool?) {                      
         switch rawValue {                       
           case true?: self = .enabled           
           case false?: self = .disabled         
           default: self = .notSet
         }
    }

    var rawValue: Bool? {                        
         switch self {
           case .enabled: return true
           case .disabled: return false
           case .notSet: return nil
         }
    }

}

// the same for other types .
```swift
enum Color {
    case red
    case green
    case blue
}
extension Color: RawRepresentable {
    typealias RawValue = UIColor

    init?(rawValue: RawValue) {
        switch rawValue {
        case UIColor.red: self = .red
        case UIColor.green: self = .green
        case UIColor.blue: self = .blue
        default: return nil
        }
    }

    var rawValue: RawValue {
        switch self {
        case .red: return UIColor.red
        case .green: return UIColor.green
        case .blue: return UIColor.blue
        }
    }
}
```

## Force unwrapping guidelines

Force unwrapping skip the checking , but it may lead crashes if value of optional type is nil. 

ideally, we should never use force unwrapper. unless below: 
|POSTPONING ERROR HANDLING | WHEN YOU KNOW BETTER THAN THE COMPILER |
|--|--|
|  "cheat yourself"| "has value for sure"  |

 


## Taming implicitly unwrapped optionals
Implicitly unwrapped optionals, or IUOs.

```swift
let lastName: String! = "Smith"      // IUO
 
let name: String? = 3
let firstName = name!                // force unwrapping
```
IUO is like a promise that we promise it will have value.  if that breaks, app will crash. 

**When do we truly need IUO ?**

IUO is like a double-edged sword.  we use it to avoid unwrapping everytime and skip the assignment in init() func. 
But, we need to take the risk of crash. (when the promise broken )

