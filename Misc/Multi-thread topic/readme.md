Operation

# Passing data between Operations
[ref](https://marcosantadev.com/4-ways-pass-data-operations-swift/)


- Internal Dependency reference 
    - make the data as a variable and reference it directly or from operationQueue
- Reference Wrapper
    - create a class and class it address reference, it maintain the data
- Completion block
    - like complitionhandler
- Adapter operation
    - have an extra BlockOperation to transitting the data
    ```
        let adapter = BlockOperation() { [unowned parse, unowned fetch] in
        parse.dataFetched = fetch.dataFetched
    }
    ```


