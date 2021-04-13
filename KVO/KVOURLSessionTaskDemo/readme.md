
# iOS: KVO for URLSessionTask state

[**This is part of the URLSessionTaskOperation**](https://github.com/RENCHILIU/PSOperations/blob/master/PSOperations/URLSessionTaskOperation.swift)

The state of URLSessionTask we have below:
```
enum State : Int {
  case running, suspended, canceling, completed //0,1,2,3
}

```


## First we can do the simple print for the state:
```
class ViewController: UIViewController {
  
  var requestTask: URLSessionTask?
  override func viewDidLoad() {
    super.viewDidLoad()
    
    requestTask = URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://www.apple.com")!)) { [weak self] (data, response, error)  in
      print("URLSession.shared.dataTask is excuting")
      print(self?.requestTask?.state.rawValue)
    }
    
    print(requestTask?.state.rawValue)
    requestTask?.resume()
    print(requestTask?.state.rawValue)
    
  }
}
```

the output should be: 
```
[1,0,3]
```


## we can also try with KVO model
```
class ViewController: UIViewController {
  
  var requestTask: URLSessionTask?
  override func viewDidLoad() {
    super.viewDidLoad()

    requestTask = URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://www.apple.com")!)) { [weak self] (data, response, error)  in
      print("URLSession.shared.dataTask is excuting")
    }
    requestTask?.addObserver(self, forKeyPath: "state", options: [], context: &requestTaskContext)
    
    requestTask?.resume()
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    guard context == &requestTaskContext else { return }
    
    if let object = object as? URLSessionTask {
      if object === self.requestTask && keyPath == "state" {
        print(" has change to --> \(object.state.rawValue)")
      }
    }
  }
}
```

the output should be:
```
has change to --> 0
has change to --> 0
has change to --> 3
```


When we are building the URLSessionTaskOperation, a concurrent operation.

We need to deal with the state by ourself and understanding how we use KVO to know the state of the URLSessionTask will help us identify the state of the URLSessionTaskOperation.
