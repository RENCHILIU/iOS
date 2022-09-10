# Working with protocols and delegates

##### The syntax of protocol:
    
    protocol ProtocolName{ 
    // List of properties and methods goes here.... 
    } 



##### Use protocol in class:

    class SampleClass: ProtocolName{ 
    } 


##### Mutating methods

    
_mutating key_
Structures and enumerations are value types. By default, the properties of a value type cannot be modified from within its instance methods
Add mutating before instance methods to change the property.

    
##### Delegation
In delegation, you enable types to delegate some of its responsibilities or functions to another instance of another type.


To create this **design pattern**, we use protocols that will contain the list of responsibilities or functions to be delegated.
_(delegate is just a design pattern)_

##### Class-only protocols
We mentioned before that classes, structures, and enumerations could adopt protocols. The difference among them is that classes are reference types, whereas structures and enumerations are value types.


    protocol ClassOnlyProtocol: class{ 
       // class only properties and methods go here 
    } 



##### Optional requirements

You see that when you list your properties and methods in a protocol, the type that conforms to that protocol should adopt to **all** properties and methods. **Skipping** one of them will lead to a compiler error. 

Some delegate methods are meant to notify you something that you don't care about. In that case, you can mark these methods as **optional**. The keyword optional can be added before properties and methods to mark them as optional.

Another thing, the protocol that has optional stuff should be marked with **@Objc**. 


