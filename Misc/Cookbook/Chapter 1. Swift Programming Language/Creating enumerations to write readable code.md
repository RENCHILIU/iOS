# Creating enumerations to write readable code
Once you find that you have **a group of related values** in your project, create enum to group these values and to define a safe type for these values. 
    
 With enumerations, your code becomes more readable and easy to understand, as it makes you **define new types** in your project that map to other value. 



##### enum syntax:
    enum EnumName{ 
    } 


##### create enum

    enum Monster{ 
        case Lion 
        case Tiger 
        case Bear 
        case Crocs 
      } 
 
      enum Monster2{ 
        case Lion, Tiger, Bear, Crocs 
      } 

##### get enum
Use the '.' operator to create enums variables from the previously created enum

##### check enum with switch

..


#### Enum raw values
    enum IntEnum: Int{ 
       case case1 = 50 
       case case2 = 60 
       case case3 = 100 
    } 




https://cocoacasts.com/four-clever-uses-of-swift-extensions

