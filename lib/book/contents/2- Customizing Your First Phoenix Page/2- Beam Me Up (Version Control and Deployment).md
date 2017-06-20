# Beam Me Up (Version Control and Deployment)

This chapter contains a lot of material that isn't directly related to Elixir and Phoenix, but is nonetheless extremely important to know.  It also contains a lot of material that is specific to certain services and operating systems- meaning that I won't be able to provide good instructions for Windows on Linux, and the instructions for these services could change independently of the Phoenix framework's upgrade cycle.

For those reasons, I'll be linking to several external guides that cover these very important subjects much more thoroughly than I could, and which will be more likely to stay up to date and cover all operating systems.  What I'll be writing are the parts that won't change either with time or with switching between operating systems.

So let's dive in!

## What is Version Control?

Let's say you're make a mistake. A horrible, life-changing mistake.  In real life you'd just have to deal with the consequences, be they jail, debt, injury, or a lifetime of shame.  But in code, you can make (most of) your mistakes disappear with just a few taps at the command line... IF you're using version control.

Using version control, you can go back in time, create alternate timelines, combine the best parts of alternate timelines, see your entire history, and even work together with other people separate from you in time and space.  This chapter will teach you the absolute basics- we'll be treating commits kind of like save files in a videogame- but there's a whole world of advanced tricks that are really useful, especially when you collaborate with other coders.

The version control system we'll be using is called "Git".

## Install Git

To see if you have `git` already installed, type `git` on the command line.  If it shows you the most commonly used commands, then congratulations- you have `git` already installed.  If it says something like "`command not found: git`" then you'll need to install it. This is a pretty good guide: https://www.atlassian.com/git/tutorials/install-git.

## Initializing a Git Project

First, let's check the status of our project according to git.  Make sure you're in the `star_tracker` folder and then type the following:

```bash
$ git status
  fatal: Not a git repository (or any of the parent directories): .git
```

This is an error, but it's one we expect.  We don't have a git repository yet!  Let's make one.

```bash
$ git init
  Initialized empty Git repository in /Users/jeffreybiles/phoenix/star_tracker/.git/
```

Your filepath will be different, but it should say something similar.  It creates a `.git` folder, where it will store all your git data.

The dot in the folder name means it's "hidden", so it may not show up by default.  You can fix that by using the `-a` option in your `ls` command.

```bash
$ ls
  README.md assets    deps      mix.exs   priv
  _build    config    lib       mix.lock  test
$ ls -a
  .          .gitignore assets     lib        priv
  ..         README.md  config     mix.exs    test
  .git       _build     deps       mix.lock
```

We won't worry about the specifics of the `.git` folder in this book, just know that deleting it is a very bad idea unless you know what you're doing.

## Our First Commit

Let's ask `git` about our status again.

```bash
$ git status
  # On branch master
  #
  # Initial commit
  #
  # Untracked files:
  #   (use "git add <file>..." to include in what will be committed)
  #
  #	.gitignore
  #	README.md
  #	assets/
  #	config/
  #	lib/
  #	mix.exs
  #	mix.lock
  #	priv/
  #	test/
  nothing added to commit but untracked files present (use "git add" to track)
```

We have lots of "untracked" files, which means that git currently has no record of them.  Let's go ahead and add all of them to our git project.

```bash
$ git add .
```

The dot here means "current directory", and since we're in the root directory of the project this command translates into "add everything".

```bash
$ git status
  # On branch master
  #
  # Initial commit
  #
  # Changes to be committed:
  #   (use "git rm --cached <file>..." to unstage)
  #
  #	new file:   .gitignore
  #	new file:   README.md
  #	new file:   Star-Tracker
  #	new file:   assets/brunch-config.js
  #	new file:   assets/css/app.css
  #	new file:   assets/css/phoenix.css
  #	new file:   assets/js/app.js
  #	new file:   assets/js/socket.js
  #	new file:   assets/package.json
  #	new file:   assets/static/favicon.ico
  #	new file:   assets/static/images/phoenix.png
  #	new file:   assets/static/robots.txt
  #	new file:   config/config.exs
  #	new file:   config/dev.exs
  #	new file:   config/prod.exs
  #	new file:   config/test.exs
  #	new file:   lib/star_tracker/application.ex
  #	new file:   lib/star_tracker/repo.ex
  #	new file:   lib/star_tracker/web/channels/user_socket.ex
  #	new file:   lib/star_tracker/web/controllers/page_controller.ex
  #	new file:   lib/star_tracker/web/endpoint.ex
  #	new file:   lib/star_tracker/web/gettext.ex
  #	new file:   lib/star_tracker/web/router.ex
  #	new file:   lib/star_tracker/web/templates/layout/app.html.eex
  #	new file:   lib/star_tracker/web/templates/page/index.html.eex
  #	new file:   lib/star_tracker/web/views/error_helpers.ex
  #	new file:   lib/star_tracker/web/views/error_view.ex
  #	new file:   lib/star_tracker/web/views/layout_view.ex
  #	new file:   lib/star_tracker/web/views/page_view.ex
  #	new file:   lib/star_tracker/web/web.ex
  #	new file:   mix.exs
  #	new file:   mix.lock
  #	new file:   priv/gettext/en/LC_MESSAGES/errors.po
  #	new file:   priv/gettext/errors.pot
  #	new file:   priv/repo/seeds.exs
  #	new file:   test/star_tracker/web/controllers/page_controller_test.exs
  #	new file:   test/star_tracker/web/views/error_view_test.exs
  #	new file:   test/star_tracker/web/views/layout_view_test.exs
  #	new file:   test/star_tracker/web/views/page_view_test.exs
  #	new file:   test/support/channel_case.ex
  #	new file:   test/support/conn_case.ex
  #	new file:   test/support/data_case.ex
  #	new file:   test/test_helper.exs
```

Calling for the status shows that git now has all these new files ready to be committed- or, in the parlance of git, "staged".

Let's take these staged files and commit them.

```bash
$ git commit -m "Our first commit"
  [master (root-commit) 3484920] Our first commit
   43 files changed, 1291 insertions(+)
   create mode 100644 .gitignore
   create mode 100644 README.md
   create mode 160000 Star-Tracker
   create mode 100644 assets/brunch-config.js
   create mode 100644 assets/css/app.css
   create mode 100644 assets/css/phoenix.css
   create mode 100644 assets/js/app.js
   create mode 100644 assets/js/socket.js
   create mode 100644 assets/package.json
   create mode 100644 assets/static/favicon.ico
   create mode 100644 assets/static/images/phoenix.png
   create mode 100644 assets/static/robots.txt
   create mode 100644 config/config.exs
   create mode 100644 config/dev.exs
   create mode 100644 config/prod.exs
   create mode 100644 config/test.exs
   create mode 100644 lib/star_tracker/application.ex
   create mode 100644 lib/star_tracker/repo.ex
   create mode 100644 lib/star_tracker/web/channels/user_socket.ex
   create mode 100644 lib/star_tracker/web/controllers/page_controller.ex
   create mode 100644 lib/star_tracker/web/endpoint.ex
   create mode 100644 lib/star_tracker/web/gettext.ex
   create mode 100644 lib/star_tracker/web/router.ex
   create mode 100644 lib/star_tracker/web/templates/layout/app.html.eex
   create mode 100644 lib/star_tracker/web/templates/page/index.html.eex
   create mode 100644 lib/star_tracker/web/views/error_helpers.ex
   create mode 100644 lib/star_tracker/web/views/error_view.ex
   create mode 100644 lib/star_tracker/web/views/layout_view.ex
   create mode 100644 lib/star_tracker/web/views/page_view.ex
   create mode 100644 lib/star_tracker/web/web.ex
   create mode 100644 mix.exs
   create mode 100644 mix.lock
   create mode 100644 priv/gettext/en/LC_MESSAGES/errors.po
   create mode 100644 priv/gettext/errors.pot
   create mode 100644 priv/repo/seeds.exs
   create mode 100644 test/star_tracker/web/controllers/page_controller_test.exs
   create mode 100644 test/star_tracker/web/views/error_view_test.exs
   create mode 100644 test/star_tracker/web/views/layout_view_test.exs
   create mode 100644 test/star_tracker/web/views/page_view_test.exs
   create mode 100644 test/support/channel_case.ex
   create mode 100644 test/support/conn_case.ex
   create mode 100644 test/support/data_case.ex
   create mode 100644 test/test_helper.exs
 ```

 So now we've committed 43 files with a total of 1291 lines of code between them (your numbers may be slightly different depending on the point version of Phoenix that you use, but they shouldn't be too far off). Thanks git for those handy stats, and thanks Phoenix for not making us write all that code ourselves!

 Let's see what our status is now.

```bash
$ git status
  # On branch master
  nothing to commit, working directory clean
```

This tells us that we've committed all the changes- everything is saved.

## Your Second Commit









## Looking at Historical Logs

Now that we've made some commits, let's look at our history by typing in `git log`

(Note: when you're doing looking at the log, press `q` to exit)



## Stashing your Mistakes





## Why Github?

* Create github account (link) (mention bitbucket and gitlab as more secure alternatives, provide links)
* Push up to github
* Create a branch
* Switch branches
* Merge the branch
* Deployment


## Deployment

"Deployment" is the process of making your app available to the wider world.  In this case, it's getting it to a web server where people can view your website (currently a barely-customized default app) by putting a URL in their browser.

For the purposes of this tutorial we recommend using Heroku.  It uses git to receive your code, and does a lot of the nitty-gritty of server management for you.  Perfect for beginners or people who are too busy to bother with handling the fine details.

If you do choose Heroku, go the their docs page ([http://www.phoenixframework.org/docs/heroku](http://www.phoenixframework.org/docs/heroku)) and follow the instruction, because I have nothing useful to add to them.  You'll need to be connected to the internet to deploy your app anyways.  Just make sure to replace all instances of hello_phoenix and HelloPhoenix with the name of your app.

If this book ever makes it to a paper edition then I'll write something up at that time.  Until then, use [the official docs](http://www.phoenixframework.org/docs/heroku).

See you in the next chapter, where we start customizing our app.
