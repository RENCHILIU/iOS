# Using closures to create self-contained code

***Closures syntax:***

    { (parameters) ->returnType in 
       // block of code goes here 
    } 

    
***Define as the variable***

    var closerParam = { (number: Int) -> Void in ...}

 ***Define as the property***
       
    typealias closerType = (Int) -> Void

* ERROR: Function types cannot have argument labels; use '_' before 'number'
* The Swift designers decided to prohibit argument labels for function types.

***Use in the func***

    func closerFunc(complete: closerType) -> Void {
        
    }


***Style***

* Basic

        names.sort{ (str1: String, str2: String) ->Bool in 
            return str1 > str2 
        } 
 
* Inferring type（omit -> parameters & return types）

        names.sort{ str1, str2 in 
           return str1 > str2 
        } 
        
* Omitting the return keyword (When closure body consists of only one expression)

        names.sort({ str1, str2 in str1 > str2}) 
            
* Shorthand arguments(refer to the argument list with names $0, $1)

        names.sort({ $0 > $1}) 


***A function with a completion handler***

![Screen Shot 2018-03-19 at 2.07.27 P](https://lh3.googleusercontent.com/-f7l8VF86GwI/WrAK-d7X0TI/AAAAAAAAPXk/GUDjmRXUcmYaC9anaQr-hHJB01eY8DcygCHMYCw/I/Screen%2BShot%2B2018-03-19%2Bat%2B2.07.27%2BPM.png)


 [link](https://stackoverflow.com/questions/30401439/how-could-i-create-a-function-with-a-completion-handler-in-swift)   



