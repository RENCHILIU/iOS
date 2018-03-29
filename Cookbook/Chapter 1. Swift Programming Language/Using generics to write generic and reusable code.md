# Using generics to write generic and reusable code

Generic code is used to write **reusable and flexible** functionalities that can deal with any type of variables.
This helps in writing **reusable and clean code** regardless of the type of objects your generic code deals with.



##### Example

_Normal Version_

    class StackInt{ 
        var elements = [Int]() 
 
      func push(element:Int) 
      { 
        self.elements.append(element) 
      } 
      func pop() ->Int 
      { 
        return self.elements.removeLast() 
      } 
      func isEmpty()->Bool 
      { 
        returnself.elements.isEmpty 
      } 
    } 
 
    var stack1 = StackInt() 
    stack1.push(5)    // [5] 
    stack1.push(10)  //[5,10] 
    stack1.push(20) // [5,10,20] 
    stack1.pop()   // 20


_General Verion_

    class Stack <T>{ 
        var elements = [T]() 
        func push(element:T) 
        { 
          self.elements.append(element) 
        } 
        func pop()->T{ 
          return self.elements.removeLast() 
        } 
      } 
 
      var stackOfStrings = Stack<String>() 
      stackOfStrings.push("str1") 
      stackOfStrings.push("str2") 
      stackOfStrings.pop() 
 
      var stackOfInt = Stack<Int>() 
      stackOfInt.push(4) 
      stackOfInt.push(7) 
      stackOfInt.pop() 


    

