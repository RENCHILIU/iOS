#  Closure


```

//---Step one
typealias myClosureType = (Int, Int) -> Int

var multiplyClosure: myClosureType

//var multiplyClosure: (Int, Int) -> Int   // define a Closure

multiplyClosure = {(a: Int, b: Int) -> Int in
    return a * b
}

let result = multiplyClosure(3,2)


//---Step two <->type inference

// in declaration, we already declare the type
multiplyClosure = { a, b in
    return a * b
}

let result2 = multiplyClosure(3,2)

//---Step three
// if you don't wanna the parameter, you can use $ sign to replace them
multiplyClosure = {
    return $0 * $1
}
let result3 = multiplyClosure(3,2)

//--- Step four
// if you only have one line , you can even remove the return
multiplyClosure = {$0 * $1}

let result4 = multiplyClosure(3,2)


```


what makes the closure as a cool thing:

**(1)function take closure as the parameter.**


```
func operateOnNumber(_ a :Int, _ b: Int, operation: myClosureType) -> Int {
    let result = operation(a, b)
    print(result)
    return result
}

let addClosure : myClosureType = {$0 + $1}


let result5 = operateOnNumber(1, 1, operation: addClosure)
let result6 = operateOnNumber(4, 2, operation: {$0 / $1})
```





**(2)closure can manipulate the data out of the scope.**

*closure can keep the data, as long as closure alive.*


    

