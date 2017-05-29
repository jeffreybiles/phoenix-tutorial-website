Now that we understand the basics of Elixir, it's time to install Phoenix and create our first app.

## Installation

<!-- TODO when editing: Update to Phoenix 1.3.0-rc.2.  This will involve creating an entirely new project -->

We're going to be using Phoenix version 1.2.1 in this tutorial.  We download it straight from github using Mix:

```bash
 $ mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new-1.2.1.ez
```

You can install the latest version by slightly altering the command:

```bash
 $ mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
 ```

## Node

We rely on [Brunch](http://brunch.io/) to compile static assets, and Brunch relies on Node.

Go to [the NodeJS site](https://nodejs.org/en/download/) and download version 5.0 or later.  The current stable release (recommended) is 6.10.2.

## Postgres

Postgres is the database we'll be using for this tutorial, although you're free to choose another SQL database if you're more comfortable there.

Installation guides are found [on the Postgres wiki](https://wiki.postgresql.org/wiki/Detailed_installation_guides)

## Your First App

---

> Much of this section is taken from [the Up and Running docs](http://www.phoenixframework.org/docs/up-and-running).

> In general, the chapters in Section 2 are gluing together a bunch of Getting Started Guides, but after that we'll get to the more exciting Original Content.

---

We'll first use Mix to generate a new Phoenix app, named star_tracker:

```bash
$ mix phoenix.new star_tracker
```

This will create a bare-bones app

```
* creating star_tracker/config/config.exs
* creating star_tracker/config/dev.exs
....
* creating star_tracker/web/templates/layout/app.html.eex
* creating star_tracker/web/templates/page/index.html.eex
* creating star_tracker/web/views/layout_view.ex
* creating star_tracker/web/views/page_view.ex
```

You can start looking around your file structure.  We'll take our first quick tour in chapter 3, and start giving detailed explanations of what everything does starting in chapter 5.

You'll be prompted to fetch and install "dependencies".  Say Yes with Y (or hitting enter to choose Y as default).

```bash
Fetch and install dependencies? [Yn] Y
```

It will then give you instructions for finishing installation

```bash
Fetch and install dependencies? [Yn] Y
* running mix deps.get
* running npm install && node node_modules/brunch/bin/brunch build

We are all set! Run your Phoenix application:

    $ cd star_tracker
    $ mix phoenix.server

You can also run your app inside IEx (Interactive Elixir) as:

    $ iex -S mix phoenix.server

Before moving on, configure your database in config/dev.exs and run:

    $ mix ecto.create
```

We'll follow those instructions

```bash
$ cd star_tracker
```

The first command Changes Directories to the newly-created folder.  `cd` is a unix shell command, but don't let the name scare you- "Unix" shell commands can be used on Linux, Mac, and Windows 10+ (with Bash).

Here's some basic commands to get you started

| Command | Description | Example |
| ------- | ----------- | ------- |
| ls      | lists files and folders in directory | ls -a |
| cd      | change directory | cd star_tracker |
| mkdir   | create directory | mkdir new_folder |
| mv      | move file | mv old_location new_location |
| cp      | copy file(s) | cp old_file new_file |
| rm      | remove file | rm old_file |

In Unix terminology `.` means "current directory", `..` means "one directory up", and `~` means the home directory.  So to move up a directory we would input `cd ..`, and to look at the files in the home directory we would input `ls ~`.

There's lots more Unix shell commands we could learn, but those should be enough to get you started.  Now back to installing Phoenix!

```bash
$ mix ecto.create
==> connection
Compiling 1 file (.ex)
Generated connection app
==> fs (compile)
Compiled src/sys/inotifywait_win32.erl
...
==> postgrex
Compiling 62 files (.ex)
Generated postgrex app
==> ecto
Compiling 69 files (.ex)
Generated ecto app
==> phoenix_ecto
Compiling 4 files (.ex)
Generated phoenix_ecto app
==> star_tracker
Compiling 12 files (.ex)
Generated star_tracker app
The database for StarTracker.Repo has been created
```

Ecto is the library that Phoenix uses to interface with the database.  We'll be learning a lot more about Ecto when creating our main app.

This particular command creates the database (Postgres by default) for our app.

Finally, we run our app.

```bash
$ mix phoenix.server
  [info] Running StarTracker.Endpoint with Cowboy using http://localhost:4000
  05 Apr 05:33:34 - info: compiled 6 files into 2 files, copied 3 in 1.7 sec
```

In your web browser, visit http://localhost:4000/.  There you should see the Phoenix Welcome page.

![](.../images/phoenix-welcome.png)

And that's your first Phoenix app!  Congratulations!

In the next chapter we'll go over how to save your code with Git and Github and deploy your site (make it publicly available on the internet) with Heroku.
