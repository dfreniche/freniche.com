---
layout: post
title: Reaching iCloud from the command line
description: "Accesing your iCloud folder and files from the command line"
tags: [icloud, terminal]
date: 2019-07-09
---

Recently I’ve abandoned Dropbox and switched over iCloud. I’ll talk about the reasons in another post, but sounds crazy to me that right now iCloud is a better option than Dropbox in the Mac...

I have different things stored in my Cloud Storage. Some repos from unfinished projects, living proof of that moment’s abandoned hype, some personal documents, all my iPad Apps docs, shared configuration for Bash / Zsh and lots of small scripts.

Up until now, to access the files in my Dropbox from the command line I had a symbolic link pointing from `$HOME/.` to `$HOME/Dropbox`. But the moment I moved everything to iCloud I thought, “OK, but where _really_ are in my file system all these files?”. Turns out iCloud stores all files in `~/Library/Mobile Documents/com~apple~CloudDocs`. I use the wonderful command-line utility [z](https://github.com/rupa/z) to jump around my file system, so it’ll be easy to `cd` there. But for this I’d rather prefer a symbolic link. So I ran this:

```
$ cd
$ ls -sf Library/Mobile\ Documents/com~apple~CloudDocs iCloud
```

This goes to the `$HOME` folder and creates a link to the desired, hidden inside `Library` iCloud folder. Now I can also reach easily that folder.

Also I added this to my .zshrc:

```
alias cd-icloud="cd $HOME/Library/Mobile\ Documents/com~apple~CloudDocs/"
``` 

So I can just type `cd-icloud` each time I need to enter iCloud from Terminal.

Which is BTW what Apple should have done in the first place.