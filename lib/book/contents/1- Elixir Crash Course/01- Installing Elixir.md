# Installing Elixir

## Hello World

Welcome to The Phoenix Tutorial.  I'm so glad you decided to join us!

---

> **Captain's Log: The Introduction**

> Stardate: far future.

> I have just discovered the first fragments of this fascinating manuscript detailing the Phoenix technology that underlies our fleet.

> At first I wasn't sure what I was reading, since it seemed to jump straight into technical instructions, but then I went back and read the Introduction and it all made sense.

> I'll be recording my observations, both for myself, and so that others my continue my research should anything... happen.

---

As we said in the intro, we'll be taking a **hands-on approach** to learning.  And that means that before we can do anything, you're going to have to get Elixir installed on your computer.

## Installation

Installing Elixir is the most system-dependent installation step of this entire book.  Each function shared will install both Elixir and Erlang, the language which Elixir builds on top of.

Check which operating system you are using and follow the associated instructions.

---

> **Captain's Log: Command Line Notation**

> When we find a dollar sign at the beginning of a line of code, it appears to signify that everything following should be typed out on the reader's "command line".

> The command line was the 21st-century equivalent of our ship computer- you tell it a command (by typing with your fingers- such barbarians!) and it does exactly what you ask.  The most common name for this command line was "bash" (as I said- violent barbarians!), but there were several other variants in use.

> I will continue reporting my findings as I uncover more of this fascinating 21st-century document.

---


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
