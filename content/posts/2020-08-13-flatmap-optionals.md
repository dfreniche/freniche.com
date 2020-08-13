---
layout: post
title: FlatMap for Optionals, took me a while to understand
description: FlatMap is not for the faint at heart. A rant.
tags: [swift, learning]
date: 2020-08-13
---

In my last post I wrote about [why I think Swift is not a simple language](https://dfreniche.github.io/posts/2020-07-27-swift-the-not-that-easy-to-learn-language/). After all, if you need powerful, expressive constructs you´ll end up having some degree of complexity in there. My critique was more about how they market it as _simple for beginners_, when sometimes I have to scratch my head to understand some code. I´m dumb as a rock, that's for sure, but have been typing code since ´88. I´ve seen a couple lines of code. I shouldn't struggle with stuff like this.

## Exhibit one

I found similar code to this example during a PR review:

```swift
let numberAsString: String? = “100”

/// ...

let n: Int? = numberAsString.flatMap(Int.init)
```

Wait, what? `flatMap`? Isn´t that a function for arrays of arrays, that apply a transform to the whole array, then _flattens_ the result into a single array? Well, yes. The idea behind `Array::flatMap` is to apply a transform to all elements inside an array, that can contain other arrays, so every element gets transformed. 

## A small detour: flatMap for Arrays

Let's look at this example:

```swift
let numbers: [Int] = [10, 20, 30, 40]
let numbersPlusOne = numbers.flatMap { $0 + 1 }
numbersPlusOne // [11, 21, 31, 41]
```

As you can see, using a _flat_ array, `flatMap` works the same as `map`: just takes one element of the array at a time, applies the transform (in this case adding one) and returns a new array with all the transformed values.

The real power of `flatMap` appears when we have an array of arrays:
```swift
let numbersGrouped: [[Int]] = [[10, 30], [20, 40]]
let numbersGroupedPlusOne = numbers.flatMap { $0 + 1 }
numbersGroupedPlusOne // [11, 21, 31, 41]
```

As you can see, here `flatMap` is ignoring the fact we're traversing an array of arrays. Just _flattens_ the array, then apply the transform. So the result is the same.

## Back to the Optional stuff

OK, so`flatMap` is also a function on Optionals, not only on Arrays. What is it good for? Let's look at this example:


```swift
let numberAsString: String? = “100”

// If we want to create a number from that Optional String, we’ll need to
// 1st unwrap the String to be sure it’s not `nil`, then trying to
// create a new Int
if let s = numberAsString, let n4 = Int(s) {
    n4
}
```

To get the value inside that `Optional<String>` and convert into an `Int`, we need to do it in two steps:
- unwrap the String to be sure it’s not `nil`, this is done in `if let s = numberAsString`
- then, take that string and create an `Int` 

To avoid this two-step, boring process, they added a function that applies a transform (in this case `Int.init` which is used to create an `Int` after making sure there's _something_ inside the `Optional`. Why not call it `applyIfSomethingInside`, `checkContentsAndApply` or any other fancy name? If any of you know the reasons, I'm all ears at [Twitter](https://twitter.com/dfreniche))

So code is now:

```swift
// flatMap accepts a trailing closure and unwraps the String for us

let n1: Int? = numberAsString.flatMap { (unwrappedString: String) -> Int? in
    return Int(unwrappedString)
}
```

We can simplify that, as there's only one line in that closure we can get rid of `return`:

```swift
let n1: Int? = numberAsString.flatMap { (unwrappedString: String) -> Int? in
    Int(unwrappedString)
}
```

And now, as there's only one parameter we can use the positional `$0` parameter like this:

```swift
let n1: Int? = numberAsString.flatMap {
    Int($0)
}
```

But we can even just pass the name of the function we want to apply, reaching our final form: 

```swift
// This is a more succint way, too succint maybe
let n3: Int? = numberAsString.flatMap(Int.init)
```

OK, so now I understand how this `flatMap` works on `Optional`. Only took me a blog post to understand it...
