## Generics

### The benefits of generics
Reducing boilerplate and avoiding Any is where generics can help.


for Function:
*You’re adding a generic <T> type parameter to your function signature.*

```swift
// Nongeneric version
func firstLast(array: [Int]) -> (Int, Int) {
    return (array[0], array[array.count-1])
}
// Generic version
func firstLast<T>(array: [T]) -> (T, T) {
    return (array[0], array[array.count-1])
}
```

### Constraining generics

sometimes, we want our generic type to have some limitation. like when we want to compare something, we want to make our item to be comparable. then the generic *T* should at least confrom the **comparable** protocol.

```swift
// Before. Didn't compile.
func lowest<T>(_ array: [T]) -> T? {

// After. The following signature is correct.
func lowest<T: Comparable>(_ array: [T]) -> T? {
```

#### Combining constraints
```swift
func lowestOccurrences<T: Comparable & Hashable>(values: [T]) -> [T: Int] {
    // ... snip
}

//Now T can be compared and put inside a dictionary inside the function body.
```


#### where  clause
```
func lowestOccurrences<T>(values: [T]) -> [T: Int]     
     where T: Comparable & Hashable {                  another way to combine the constrain
     // ... snip
}
```

### Creating a generic type

```swift
struct Pair<T: Hashable, U: Hashable> {       
    let left: T
    let right: U                              
 
    init(_ left: T, _ right: U) {             
      self.left = left
      self.right = right
    }
}
```

### Generics and subtypes
Subclassing is one way to achieve polymorphism; generics are another.

**[RISK]**
Passing a subclass when your code expects a superclass is all fine and dandy. But once a generic type wraps a superclass, you lose subtyping capabilities.

we can assign a subclass to a superclass declared instance. 
but we cannot replace superclass generic with subclass .


```swift
struct Container<T> {}

var containerSwiftCourse: Container<SwiftOnTheServer> =
 Container<SwiftOnTheServer>()
var containerOnlineCourse: Container<OnlineCourse> = containerSwiftCourse

//error: cannot convert value of type 'Container<SwiftOnTheServer>' to specified type 'Container<OnlineCourse>'

====

struct Cache<T> {
    // methods omitted
}
func refreshCache(_ cache: Cache<OnlineCourse>) {
    // ... snip
}

refreshCache(Cache<OnlineCourse>()) // This is allowed
refreshCache(Cache<SwiftOnTheServer>()) // error: cannot convert 
 // value of type 'Cache<SwiftOnTheServer>' to expected argument type 'Cache<OnlineCourse>'
```


**[RISK]**

Swift’s generic types, such as Array or Optional, do allow for subtyping with generics. 

In other words, Swift’s types from the standard library do not have the limitation you just witnessed. Only the generics that **you define yourself** have the limitations.

```
func readOptionalCourse(_ value: Optional<OnlineCourse>) {
    // ... snip
}

readOptionalCourse(OnlineCourse()) // This is allowed.
readOptionalCourse(SwiftOnTheServer()) // This is allowed, Optional is covariant.

```