---
date: 2019-06-01
title: SWIFT
description: ""
tags: [swift, iOS]

---

## Using a class' method as default parameter in Swift

[Using a class' method as default parameter in Swift](https://stackoverflow.com/questions/56145155/using-a-class-method-as-default-parameter-in-swift/56145347#56145347)

[Instance Methods are “Curried” Functions in Swift](https://oleb.net/blog/2014/07/swift-instance-methods-curried-functions/)

```
import UIKit

func externalAdd(n1: Int, n2: Int) -> Int {
    return n1 - n2
}

class Calculator {
    
    func operate(n1: Int, n2: Int, _ f: ((Int, Int) -> Int)? = nil) -> Int {
        return (f ?? add)(n1, n2)
    }
    
    func add(n1: Int, n2: Int) -> Int {
        return n1 + n2
    }
}


Calculator().operate(n1: 10, n2: 20)
Calculator().operate(n1: 10, n2: 20, externalAdd(n1:n2:))
```