---
layout: post
title: Using a local and global Cocoapods executable

description: How to use a local version of cocoapods that doesn't conflict with your global version 
tags: [ios, cocoapods, bash]
date: 2020-10-28
---

# The problem

You have a project that uses Cocoapods to solve all your dependencies needs. Everything works OK until one of your coworkers updates his version of Cocoapods (it's never you, it's always _one of the others_ in these kind of stories). Then he makes some changes, and those changes are incompatible with the version you have.

# A solution

Your team hold a meeting. You all decide settling on a certain version number. You even write that version down somewhere. Documentation FTW! But you don't enforce that _tool dependency_.

# The problem, take two

Even as it's been agreed, people forget, or upgrade Cocoapods by mistake. You're again having the initial problem. Again, blame is to put in _one of your coworkers_. You can't be that stupid, can you?

# A solution, improved

You decide to use a local version of Cocoapods that's independent of the global version you have installed in your system. This way, you have your agreed version documented somewhere and also this tool dependency is automated. As Cocoapods is a Ruby thing, you use [Bundler](https://bundler.io/).

> Bundler provides a consistent environment for Ruby projects by tracking and installing the exact gems and versions that are needed. 

In short, you install Bundler, then add a config file for Bundler (a `Gemfile`) stating the exact versions for all the gems you'll use (useful not only for Cocoapods, but also for Fastlane for instance) and run `bundle install`.

An example of a `Gemfile` is below

```ruby
source "https://rubygems.org"

gem "cocoapods", '~> 1.8.4'
gem "fastlane"
gem "xcpretty"

```

# The problem, take three

Now your team has to use `bundle exec pod install` and `bundle exec pod update` each time they want to update the dependencies of your project. But there's still room for error and Murphy strikes back and _somebody_ (remember, never it's you) does a `pod install`, using the non-agreed Cocoa Pods version.


# A solution, improved++

Let's use some bash trickery! The idea is to write a bash alias that reads our current directory. If there's no `Gemfile`, then use the global Cocoapods version. If there's a `Gemfile` around, look for a line with `cocoapods` in it. If it's there, run Cocoapods through Bundler.

So now you can use `bundle exec pod install`, which will use the local installed version of Cocoapods, or if you use `pod install` it will autocorrect to the former. Profit!


```bash
# Put this in your .bashrc, .profile, etc.

function mypod() {
  if [ -f "Gemfile" ]; then
    A=`cat Gemfile | grep cocoapods`
    if [ -z $A ]; then
      # Gemfile without local cocoapods
      $SYSTEM_POD $@
    else
      bundle exec pod $@
    fi
  else
      $SYSTEM_POD $@
  fi
}

# we search for the global pod gem and store its path here
export SYSTEM_POD=`which pod`
alias pod=mypod
```