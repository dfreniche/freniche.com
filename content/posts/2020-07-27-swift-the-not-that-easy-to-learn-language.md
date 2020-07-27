---
layout: post
title: Swift, the simple and easy to learn language?
description: Although marketed as a simple language, I don´t see Swift as beginner-friendly as they imply...
tags: [swift, learning]
date: 2020-07-27
---

![A pile of books](/img/kimberly-farmer-books.jpg)

Photo by [Kimberly Farmer](https://unsplash.com/@kimberlyfarmer?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText) on [Unsplash](https://unsplash.com/s/photos/learn?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText)


Apple markets Swift as _[The powerful programming language that is also easy to learn](https://developer.apple.com/swift/)._

Nope.

Sorry to break this on you, but Swift is far from  _easy_ to learn. This is something I’ve been commenting in the past in Twitter, Slack and private conversations with other devs. To set a baseline, if I say Swift is not easy to learn, what would an _easy to learn language_ look like? In my opinion:

- Should stick to one paradigm. Either it’s imperative (or imperative++ AKA object oriented). Or functional. Or whatever. But just one paradigm. One way of think. One way of coding. Easy to read examples. Easy to learn.
- Error messages should be clear. Some of Swift’s llvm error messages are among the most cryptic I’ve read in my career. And I can tell you I’ve seen a lot of error messages. I’m just bad at this programming thing. 
- Language should be forgiving. Maybe you didn’t get everything perfectly aligned and in place but smart defaults should help you. For instance if you try to print an Optional value that already has something in it, it should be printed without a warning. And an a clear message. What does an `Optional(something inside here)` adds to your debug logs when you print something?
- You shouldn’t be forced to understand advanced concepts to write simple stuff. `Optionals` are all over the place from the very beginning. And that forces you to understand conditionals and forced unwrapping. And `if let` structures. Also `switch` structures quickly become complex, with pattern-matching, etc.
- Tools should be consistent. Nothing can frustrate a person starting to learn Swift more that some weird problem with the simulator not starting. While coding _in a playground_. By the way, what’s a _Simulator_? 
- Editor crashing / stopping working is of great help for beginners too. REPL crashes were so common in good ol’ Swift 1.0, but they are still here with us. BTW you can still get  that nostalgic crashing experience using my little [Crashlet tool](https://github.com/dfreniche/crashlet). 100% nostalgia and annoyances guaranteed, with none of the crashes. 

If you have functional, protocol oriented, object oriented, FRP oriented and generics all in the same place it gets quickly crowded. And confusing. Swift is the land of 1000 paradigms.

- Why there are two ways to define models, one as value types and the other as reference types?
- Why enums are almost classes, but then different?
- Why having `guard` when a simple `if` can do the same?
- With `structs` you solve two problems: favor composition vs. inheritance and favor immutability through the use of value types. For a beginner trying to make a button download an image, that means less than nothing.
- Why can one pass around blocks of code if you can also just pass the name of a function?
- Why generics syntax in classes / structs is different from Protocols?

Don’t get me wrong. The more bells and whistles, or tools, a language gives you, the more flexibility you have to write your code. You have a wider range of stuff to choose from. But as nice as this is for the _seasoned developer_, it can become a nightmare for the _aspiring developer_, buried under just so many concepts. Trying to learn the _simple_ language.


If you want to learn Swift and it’s your first language, you need to learn _some practices_ before applying _best practices_. But everybody wants to show they’re on top of their game, and teaching simplified, _beginner_ stuff sounds boring, so they dismiss it quickly. But new developers need clear paths through the same jungle of knowledge you _machete’d_ your way through in the past.

My proposal for people starting with Swift is always the same: write simple code, with just a few language constructs, don’t worry, make the thing work, have some fun, read, learn, go back and improve your code when you know a new construct, GOTO 1.

- only use classes in your code. Ignore structs.
- Only use `var`. Ignore inmutability. Ignore `lets` while possible
- Never define anything as optional. Unwrap everything using `if let` and don’t use optionals.
- Learn how to use `if` and after a while you’ll appreciate `guard`
- Good old loops are your friend. Use `for` and `while`. Leave `map` for a later stage.
- Don’t use the global scope (functions or data outside Classes) at the beginning.
- Learn how the Delegate Pattern works.
- Write simple, dirty code. Then write some more. Fix it. You’ll learn more advanced structures, tips and tricks as you advance.

And no, don’t think learning SOLID principles, MVVM or other stuff at the beginning is good. These are refinements to make an app more easily maintainable, testable, readable and expandable. Those are production goals, sought after by experienced developers who have suffered bad code in the past. But those are not learning goals for beginners. And no, you can’t go from knowing nothing to doing it perfectly. This is not The Matrix. We need to experiment, build, make our own mistakes, then learn more and improve.

You can explain all Newton laws 1000 times to your kids. But they will fall off the bicycle the first time they try to ride. Does teaching them how to conserve momentum or how to drink from the water bottle while pedaling makes any sense when they haven’t yet enjoyed cycling up and down your street, feeling the wind in their faces for the first time?

Now apply the same mindset with your mentees.  