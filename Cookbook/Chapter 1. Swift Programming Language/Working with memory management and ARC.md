# Working with memory management and ARC

Though ARC manages your memory **automatically**, some mistakes may ruin your memory with no mercy if you didn't understand the concept of memory management.


##### Some notes

* Assigning a **class instance** to variable, constant, or properties will create a strong reference to this instance. The instance will be kept in memory as long as you use it.
* Setting the reference to **nil will reduce** its reference counting by one (once it reaches zero, it will be deallocated from memory). **When your class deallocated from memory, all class instance properties will be set to nil as well.**



_When your class deallocated from memory, all class instance properties will be set to nil as well._




##### Example：

    class Dog{
        var name: String
        var owner: Person!
        init(name: String){
            self.name = name
        }
    }
    class Person{
        var name: String
        var id: Int
        var dogs = [Dog]()
        init(name: String, id: Int){
              self.name = name
              self.id = id
        }
    }
    
_Solve_

    class Dog{
        var name: String
        weak var owner: Person!
        init(name: String){
            self.name = name
          }
    }

_Problem_
We have a retain cycle problem here, which means we have two objects in memory; each one has a strong reference to the other. This leads to a cycle that prevents both of them from being deallocated from memory.

_Reason_
This problem is a common problem in iOS, and not all developers note it while coding. We call it as **parent-child relation**. 

Parent (in our case, it's the Person class) should always **have a strong reference to child (the Dog class)**; **child should always have a weak reference to the parent.** 

Child doesn't need to have strong reference to parent, as **child should never exit when parent is deallocated from memory**.


--

##### More


The reference cycle problem can happen in situations other than relations between classes. **When you use closure**, there is a case where you may face a retain cycle. 


It happens when you **assign a closure to a property** in class instance and then this **closure captures** the instance. 

Let's consider the following example:

    class HTMLElement { 
     
    let name: String 
    let text: String? 
     
    lazy var asHTML: () -> String = { 
    if let text = self.text { 
    return "<\(self.name)>\(text)</\(self.name)>" 
            } else { 
    return "<\(self.name) />" 
            } 
        } 
     
    init(name: String, text: String? = nil) { 
            self.name = name 
    self.text = text 
        } 
    } 
     
    let heading = HTMLElement(name: "h1", text: "h1 title") 
    print(heading.asHTML()) // <h1>h1 title</h1>



We have the HTMLElement class, which has closure property asHTML. Then, we created an instance of that class which is heading, and then we called the closure to return HTML text. 

The code works fine, but as we said, it has a reference cycle. The instance **set closure to one of its property**, and the closure **captures** the instance (happens when we call self.name and self.text inside the closure). 


The closure in that case will **retain self** (have a strong reference to the heading instance), and at the same time, **heading already has a strong reference to its property asHTML**. 

To solve reference cycle made with closure, add the following line of code as first line in closure:

    [unowned self] in
    

The unowned keyword informs the closure to use a weak reference to self instead of the strong default reference. 




https://stackoverflow.com/questions/24320347/shall-we-always-use-unowned-self-inside-closure-in-swift?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa

