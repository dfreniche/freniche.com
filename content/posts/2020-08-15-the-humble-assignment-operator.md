---
layout: post
title: The humble assignment operator in Swift
description: You need "consistent spacing" to assign values. Go figure.
tags: [swift, learning]
date: 2020-08-15
---

You're starting to learn _any_ programming language. From Assemmbler to Clojure, from Swift to COBOL. At some point you'll want to assign a value to a memory position. It can be a constant or a variable. You just want to change that memory position. This is something so basic that CPUs have lots a lots of operations devoted to moving data around: setting the CPU registers, copying blocks of bytes from one place to another, moving data into the stack, etc. etc. Assigning is fundamental to any programming language.

Yet here we are again, Swift. I've seen this problem hitting my students starting with the language. It also hit me at the beginning. I even filed a Radar for it, but was closed. This is the problem:

- this code works

```swift
let b = 10
```

- this also works

```swift
let b=10
```

- this doesn't. Wait, what?

```swift
let b =10
let c= 10
```

If you try any two of the latter, you'll get a nice error telling you _'=' must have consistent whitespace on both sides_. That is, you either put _spaces_ on each side or no spaces at all. This is not only not forgiving for the aspiring developer, it's super confusing because you don't have this seemingly random restriction in other languages.

But it's worst for you in the audience with Programming-OCD. Whitespace can be _inconsistent_ but compiler-correct. Like so:

```swift
let b =   10
let c     = 10
```

All in all, don't prepend/append anything to the `=` operator. This confuses Swift. Most probably because assignment is so important they don't even let you overload it. See?, it's important. Now make it more friendly.