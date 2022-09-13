## Effortless error handling

### Errors in Swift

| Error type | When / How |
|--|--|
|_Programming errors_  | Array being out of bounds, numbers divided by zero , etc. we can solve it in code level |
|_User errors_|triggered by user, junk file upload. a good design will help |
|_Errors revealed at runtime_|like no internet, no hard drive space, cert expired, JSON parse, etc.|


#### The Error protocol

Error in swift is just a protocol ,  we create error by conforming this Error protocol with enum, struct , etc.



### Error propagation and catching
A useful practice when handling propagated errors is to centralize the error-handling.

```swift
struct ErrorHandler {

    static let `default` = ErrorHandler()                   
 
    let genericMessage = "Sorry! Something went wrong"      
 
    func handleError(_ error: Error) {                      
         presentToUser(message: genericMessage)
    }

    func handleError(_ error: LocalizedError) {             
         if let errorDescription = error.errorDescription {
            presentToUser(message: errorDescription)
        } else {
            presentToUser(message: genericMessage)
        }
    }

    func presentToUser(message: String) {                   
         // Not depicted: Show alert dialog in iOS or OS X, or print to
![](https://learning.oreilly.com/api/v2/epubs/urn:orm:book:9781617295188/files/cc.jpg) stderror.
        print(message) // Now you log the error to console.
    }

}
```


### Delivering pleasant APIs
Understand below : 
try?:  optional result 
try!  : like force unwrapping to try 


the init can also be ? and we can try to init
