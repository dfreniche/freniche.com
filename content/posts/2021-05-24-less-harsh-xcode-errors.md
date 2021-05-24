---
layout: post
title: Less Harsh Xcode Errors

description: A funny way to make Xcode comfort me after every single project build error 
tags: [xcode, bash]
date: 2021-05-24
---

Coding is sometimes hard. We all know this. But dealing with compiler errors is one of the worst parts. You have this idea in your mind, you want to try it quickly and then, 💥 compiler error! You forgot those semicolons! Or you added them and your language doesn't like them! Or that class lacks a constructor! 

Whatever the reason, compiler errors are always harsh: we made a mistake, and the compiler is not forgiving. Like the know-it-all it is, reminds us about how fragile our knowledge is about Swift. It's a rite of passage if you want to get some bytes compiled into machine code...

The other day I ran into a couple errors and thought "why isn't the compiler a bit more constructive while showing me errors? Specially after this looong year, can't it be a little less "compily" and a bit more "syntax-checker buddy"? So I decided to take matters in my own hands and dived into [Xcode Behaviors Settings](https://www.avanderlee.com/xcode/xcode-behaviours-optimized/)

Maybe you already know it, or not, but you can tell Xcode what it should do when it starts building your project. For instance you can switch to a view of code only, no debug area opened. Or while running tests, change to a different configuration. Or show automatically those debug panels while debugging.

In this case, I wanted to hear a nice message from Xcode each time my project failed to build. So I went into `Settings > Behaviors` and in the `Build | Fails` section scrolled to the bottom. It can run a script every time your project fails building. This could be used to launch a useful script, post a message in a Slack channel or doing something else. I decided to use [`say`](https://ss64.com/osx/say.html) and hear a random support message each time.

![Xcode behaviors screen open](/img/xcode-behaviors.png)

This is the script I'm using. Feel free to improve upon it. Hope it helps. At least my Xcode seems to worry a bit about my constant failures now.

```bash
#!/bin/bash

# gets a random number between 0...9
TXT_IDX=${RANDOM:0:1}

# I declare an array here
declare -a arr=(
"Love"
"Yes, didn't compile, but take care of yourself, you're not the problem, don't measure your self worth just in successful compiles" 
"Hugs!" 
"Failed again but we love you" 
"I'm just a compiler, don't want to hurt you" 
"Next time I promise it'll be better"
"It's me, not you"
"Sending love"
"Try again"
"Fail fast is a good thing, isn't?"
"Hugs")

# we call say to speak out loud the message selected randomly!
say ${arr[TXT_IDX]}

```