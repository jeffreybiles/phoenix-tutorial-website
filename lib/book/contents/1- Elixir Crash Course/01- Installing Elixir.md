# Hello World

## Intro

Welcome to Phoenix Tutorial!

We'll be taking a **hands-on approach** to learning, which means you'll be practicing each concept quickly after you learn it, applying it in a real application when possible.  In addition to the code given in each chapter (which you should type into your computer and run), there will also be exercises, which I highly recommend you do- if you want to remember what you're learning.

Throughout this book we're going to be building the Star Tracker app, which boldly goes where no inventory management app has gone before.

![Insert picture of finished app here]()

It's not super fancy, but it gives us many opportunities to solidify the core concepts you'll need to start creating your own Phoenix apps (and understand the more advanced Elixir and Phoenix books, should you choose to read them).

## Prerequisites

This book is designed for beginners, and as of this writing is the most beginner-friendly Phoenix book, but it is not meant as a "learn to program" book.  If you want to learn to program, here are some good (free) resources:

* [Intro to Computer Science](https://www.udacity.com/course/intro-to-computer-science--cs101) (A video course that teaches Python basics)
* [How to Design Programs](http://www.htdp.org/2003-09-26/) (this Lisp book is how I learned)
* [Invent With Python](http://inventwithpython.com/) (Book series that involves making lots of games)

If you already know how to program, here are some other things that are recommended before diving into this book:

* Command line basics (cd, ls, mkdir, rm -rf, etc.)
* Html and CSS basics (tags, classes, ids, etc.)
* Git and Github
* Navigating your favorite text editor

If you don't know some of the above and want to struggle through anyways, that's fine too- I'll try and provide cursory explanations of them when they come up, but these explanations will not be the main focus of the book.

## Should I Know Elixir?

One thing you may think is a prerequisite- but isn't- is the Elixir language. I'll cover the basic building blocks in the rest of Part 1, then introduce concepts in a "just in time" manner after that.

The biggest downside to this approach is that it can result in conflating Phoenix with Elixir, and being at a loss when looking at a non-Phoenix Elixir applications.  I don't think this is that big of a problem (I learned Ruby through Rails, where language/framework conflation is rampant, and I did fine), but if you're worried then you can check out these great Elixir learning resources:

* [Try Elixir](https://www.codeschool.com/courses/try-elixir)
* [Programming Elixir 1.3](https://pragprog.com/book/elixir13/programming-elixir-1-3)

## Why Phoenix? Why Elixir?

(This section is more advanced than the rest of the introduction.  It's also aimed at differentiating Phoenix from its predecessor/inspiration Ruby on Rails.  Feel free to skim.)

The current king of the backend Web Framework world is Ruby on Rails- it's what is taught at hundreds of Coder Bootcamps and used at thousands of startups (as well as some large companies).  However, many of the leading lights of the Ruby and Rails worlds have moved on, and a significant number of them have moved to Elixir and Phoenix.  Why is that?

![Twitter joke about Rails and Phoenix](../images/01/ruby-to-phoenix-joke.png)

The simple answer is that Elixir combines the power, speed, and reliability of the Erlang VM with the beauty and expressiveness of Ruby syntax.  In one stroke it fixes the biggest complaint about each language- speed for Ruby and syntax for Erlang.

The Elixir ecosystem has also learned a lot from both languages.  From Ruby it takes many of the most popular tools and combines them into one tool with a consistent interface: Mix.  From Erlang it takes... the entire Erlang ecosystem; you can use any Erlang package you want in Elixir (just be prepared to look at some not-as-beautiful code).

Phoenix itself has benefited greatly from seeing what Rails has done.  It's taken what worked well (convention over configuration, REST, the Rails MVC style, friendly build tooling, etc.) while doing some much-needed modernization.  Some of the modernizations are made available simply by escaping the inertia of the Rails codebase and creator DHH's opinions.  Others are unlocked due to the increased power and features of Elixir as compared to Ruby.

So here are the biggest advantages of Phoenix and Elixir, in fancy listicle form:

* SPEED

Elixir is an order of magnitude (~10X) faster than Ruby right out of the box.  This not only gets you faster response times and lets you handle more requests per box, but it eliminates a whole class of performance hacks and opens the door for doing things that would not be wise in Ruby.

* Reliability

Elixir is built on the Erlang VM, which has created systems with "nine nines" of reliability- that is, it was working 99.9999999% of the time.  This reliability isn't necessarily because individual parts crash less often, but because it can recover seamlessly from crashes- a "self healing" network of processes.  We won't get into this mechanism in detail in this book.

* Real-time features

Channels/Sockets that are just as easy as in Node (the current Sockets king), but in Elixir they're more performant.  This means that "real-time" communication between server and client is a breeze compared to other languages and frameworks.

* Functional Programming Style

This can occasionally cause frustration for those coming from an Object-Oriented language (such as Ruby), but once you become acclimated it means fewer bugs and more readable code.  You also get really cool features like Pattern Matching and piping that are not available in Object-Oriented languages.


## Installing Elixir

The focus of this book is not installing stuff, but I'll provide quick instructions for the major platforms and links to more detailed instructions where needed.

Installing Elixir is the most system-dependent installation step of this entire book.  Each method shared will install both Elixir and Erlang, the language which Elixir builds on top of.

### Mac

1. Install or update homebrew

```bash
$ /usr/bin/ruby -e "$(curl -fsSL
https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

or

```bash
$ brew update
```

2. Install Elixir

```bash
$ brew install elixir
```

### Windows

Download the Installer and run it: https://repo.hex.pm/elixir-websetup.exe

If you're using Windows, make sure you have the Bash shell installed (https://msdn.microsoft.com/en-us/commandline/wsl/about).  This new feature, available on Windows 10 and above, will allow you to use the same shell commands as Linux and Mac users.

### Other

You can find instructions for other platforms (mostly Linux flavors) at http://elixir-lang.org/install.html.

If your Linux is Debian-based, be sure to explicitly install Erlang so you can get all the necessary packages (instructions here:
http://www.phoenixframework.org/docs/installation#section-erlang)

## Installing Hex

From here on out things get (generally) platform-agnostic.  There are a couple of extra commands for those on Debian-based systems, which can be found on the Phoenix Installation Guide: http://www.phoenixframework.org/docs/installation

Hex is the Erlang package manager, which lets us specify and download our dependencies.  Mix is our Elixir task runner.  We'll use Mix (which came with Elixir) to install Hex.

```bash
$ mix local.hex
```

We'll talk more about both of these later.

## Conclusion

We've got Elixir installed now and we're ready to start learning!  In the next couple chapters we'll go over the basics of the language, with a preference towards what is most commonly used in Phoenix.
