#  guard let VS if let


```

/*
 if let VS guard let
 变量名一样，
 使用guard let 后面的name自动是变为解包值
 */

func demo(name: String?){
    if let name = name{
        print(name)
    }
    print(name ?? "nil")  //optional value
    // print(name!)
}

func demo2(name: String?){
    guard let name = name else{
        print("nil")
    }
    print(name)     // value
}

//还有个好处就是可以避免代码阻塞， guard if 提前返回一个异常情况

```

