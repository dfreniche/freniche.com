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

--- 

## @objc and @nonobjc

https://stackoverflow.com/questions/41036045/when-objc-and-nonobjc-write-before-method-and-variable-in-swift

```
objc

Apply this attribute to any declaration that can be represented in Objective-C — for example, non-nested classes, protocols, nongeneric enumerations (constrained to integer raw-value types), properties and methods (including getters and setters) of classes and protocols, initializers, deinitializers, and subscripts. The objc attribute tells the compiler that a declaration is available to use in Objective-C code.

...

nonobjc

Apply this attribute to a method, property, subscript, or initializer declaration to suppress an implicit objc attribute. The nonobjc attribute tells the compiler to make the declaration unavailable in Objective-C code, even though it is possible to represent it in Objective-C.
```


## Made app use a File type

[Files]

info.plist
```
<key>CFBundleDocumentTypes</key>
	<array>
		<dict>
			<key>CFBundleTypeIconFiles</key>
			<array/>
			<key>CFBundleTypeName</key>
			<string>Images</string>
			<key>CFBundleTypeRole</key>
			<string>Viewer</string>
			<key>LSHandlerRank</key>
			<string>Alternate</string>
			<key>LSItemContentTypes</key>
			<array>
				<string>public.image</string>
                <string>com.adobe.pdf</string>
			</array>
		</dict>
	</array>
```
To manage PDFs and images