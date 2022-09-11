# Table of contents

- [Demystifying initializers](#demystifying-initializers)
  - [Struct initializer rules](#struct-initializer-rules)
  - [Initializers and subclassing](#initializers-and-subclassing)
- [Minimizing class initializers](#minimizing-class-initializers)
  - [Convenience overrides](#convenience-overrides)
- [Required initializers](#required-initializers)
  - [when to use required keyword](#when-to-use-required-keyword)
  - [a way to avoid required keyword](#a-way-to-avoid-required-keyword)

## Demystifying initializers

### Struct initializer rules

like other languages,  struct will get a free memberwise initializer until we introduce a customized initializer. 
If we add customized initializer inside struct, the free memberwise initializer will be "deleted". but in the extension of struct , the memberwise initializer will be there.

ps: classes don’t get free memberwise initializers like structs do.

### Initializers and subclassing

|Type of initializer|usage|Linking|
|--|--|--|--|
|Designated intializer  | make sure all properties get initialized | Designated initializers point to a superclass if there is one |  |
| Convenience initializer | make initialization easier by supplying default values or create a simpler initialization syntax | can call other convenience initializers, but they ultimately call a designated initializer from the same class |  |

#### Losing convenience initializers
_once a subclass adds unpopulated properties, consumers of the subclass lose ALL the superclass’s initializers_ (you have to create by your own to finish the initialization)
Why ? becuase the convenience init() cannot finish the initializing ! 

#### Getting the superclass initializers back
By overriding the _designated_ initializer from a superclass, a subclass gets the superclass’s initializers back.
**But** you need to handle the new properties inside of your override init. 
```swift
class MutabilityLand: BoardGame {
     // ... snip
    override init(players: [Player], numberOfTiles: Int) {
        self.instructions = "Read the manual"     //handle the new properties                      
        super.init(players: players, numberOfTiles: numberOfTiles)
    }
}
```

## Minimizing class initializers

### Convenience overrides
after we overrided a designated initializer from super class, the current class has 2 designated initializers. 
this will make the its next level subcalss to override both of them to get the superclass initializers back. 

**solution:**  

we need to connect these 2 designated initializers.  by using convenience override and internal call another designated initializer. 
```swift
 convenience override init(players: [Player], numberOfTiles: Int) {   // convenience override
        self.init(players: players, instructions: "Read the manual",
     numberOfTiles: numberOfTiles)                                       // internally call another designated initializer
    }
    init(players: [Player], instructions: String, numberOfTiles: Int) {  //designated initializer to make sure all properties get initialized. 
        self.instructions = instructions
        super.init(players: players, numberOfTiles: numberOfTiles)
    }

//by doing this , the next level subclass only has to (conveniece) override the designated initializer
```

## Required initializers

Adding the required keyword assures that subclasses implement the required initializer.

### when to use required keyword

#### 1. Factory methods
 
 First, the subclass will get the **class function** from its superclass . When we had init() inside the class func, that **self.init** wouldn't work properly .  as it doens't know to create which instance. as class func can be called by any subclasses or super classes itself. 
To address this , we need all subclasses to implement its own init whcih will be used inside of that **class function**. 
How ? by adding the required keywork. 

#### 2. Protocols

When a protocol has an initializer, a class adopting that protocol _must_ decorate that initializer with the required keyword.
why? becuase all subclasses will conform the protocol and the same situation will show. 


### a way to avoid required keyword
as the issue is from subclasses, to make the class as final . we can avoid required keyword. (also helps with performace.)
