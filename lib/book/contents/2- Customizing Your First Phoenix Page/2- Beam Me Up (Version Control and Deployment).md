# Beam Me Up (Version Control and Deployment)

This chapter contains a lot of material that isn't directly related to Elixir and Phoenix, but is nonetheless extremely important to know.  It also contains a lot of material that is specific to certain services and operating systems- meaning that I won't be able to provide good instructions for Windows on Linux, and the instructions for these services could change independently of the Phoenix framework's upgrade cycle.

For those reasons, I'll be linking to several external guides that cover these very important subjects much more thoroughly than I could, and which will be more likely to stay up to date and cover all operating systems.  What I'll be writing are the parts that won't change either with time or with switching between operating systems.

So let's dive in!

## What is Version Control?

Let's say you're make a mistake. A horrible, life-changing mistake.  In real life you'd just have to deal with the consequences, be they jail, debt, injury, or a lifetime of shame.  But in code, you can make (most of) your mistakes disappear with just a few taps at the command line... IF you're using version control.

Using version control, you can go back in time, create alternate timelines, combine the best parts of alternate timelines, see your entire history, and even work together with other people separate from you in time and space.  This chapter will teach you the absolute basics -- we'll be treating commits kind of like save files in a videogame -- but there's a whole world of advanced tricks that are really useful, especially when you collaborate with other coders.

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
  On branch master

  No commits yet

  Untracked files:
    (use "git add <file>..." to include in what will be committed)

    	.formatter.exs
    	.gitignore
    	README.md
    	assets/
    	config/
    	lib/
    	mix.exs
    	mix.lock
    	priv/
    	test/

  nothing added to commit but untracked files present (use "git add" to track)
```

We have lots of "untracked" files, which means that git currently has no record of them.  Let's go ahead and add all of them to our git project.

```bash
$ git add .
```

The dot here means "current directory", and since we're in the root directory of the project this command translates into "add everything".

```bash
$ git status
  On branch master

  No commits yet

  Changes to be committed:
    (use "git rm --cached <file>..." to unstage)

  	new file:   .formatter.exs
  	new file:   .gitignore
  	new file:   README.md
  	new file:   assets/.babelrc
  	new file:   assets/css/app.css
  	new file:   assets/css/phoenix.css
    ......
  	new file:   lib/star_tracker/application.ex
  	new file:   lib/star_tracker/repo.ex
  	new file:   lib/star_tracker_web.ex
  	......
  	new file:   lib/star_tracker_web/views/page_view.ex
  	new file:   mix.exs
  	new file:   mix.lock
  	......
  	new file:   test/test_helper.exs
```

Calling for the status shows that git now has all these new files ready to be committed -- or, in the parlance of git, "staged".

Let's take these staged files and commit them.

We'll use the `git commit` command, and pass the "message" option with `-m` and a string that will be used for your commit message.

```bash
$ git commit -m "Our first commit"
  [master (root-commit) 6e6ab4a] Our first commit
  47 files changed, 12588 insertions(+)
  create mode 100644 .formatter.exs
  create mode 100644 .gitignore
  create mode 100644 README.md
  create mode 100644 assets/.babelrc
  create mode 100644 assets/css/app.css
  create mode 100644 assets/css/phoenix.css
  ......
  create mode 100644 lib/star_tracker/application.ex
  create mode 100644 lib/star_tracker/repo.ex
  create mode 100644 lib/star_tracker_web.ex
  ......
  create mode 100644 lib/star_tracker_web/views/page_view.ex
  create mode 100644 mix.exs
  create mode 100644 mix.lock
  ......
  create mode 100644 test/test_helper.exs
 ```

 So now we've committed 47 files with a total of 12588 lines of code between them (your numbers may be slightly different depending on the point version of Phoenix that you use, but they shouldn't be too far off). Thanks git for those handy stats, and thanks Phoenix for not making us write all that code ourselves!

 Let's see what our status is now.

```bash
$ git status
  # On branch master
  nothing to commit, working tree clean
```

This tells us that we've committed all the changes. Everything is saved.

## Your Second Commit

Let's make a small change, then create a new git commit.

We'll make our change in README.md.  Go in that file and at the end add the following:

```
## Custom Instructions

We're going to add our custom instructions here.
```

It's some nonsense stuff, but the important part is that, once you save the file, we'll have more changes.

Go ahead and check the git status again:

```bash
$ git status
  On branch master
  Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git checkout -- <file>..." to discard changes in working directory)

  	modified:   README.md

  no changes added to commit (use "git add" and/or "git commit -a")
```

Now let's add the file.

```bash
$ git add README.md
```

Notice that now we're adding a specific file to the staged changes, instead of adding all available files like we did previous with `git add .`.  The effect would be the same in this case, since that's the only file changed, but I wanted to show that you could be more selective in adding to a commit.

Let's check out status.

```bash
$ git status
  On branch master
  Changes to be committed:
    (use "git reset HEAD <file>..." to unstage)

  	modified:   README.md
```

It shows that we've modified the README file.

Now let's commit it.

```Bash
$ git commit -m "update the readme to add custom instructions"
  [master 17f7669] update the readme
   1 file changed, 4 insertions(+)
```

Congrats!  You made your second commit!

## Looking at Historical Logs

Now that we've made some commits, let's look at our history by typing in `git log`

```bash
$ git log
```

```bash
commit 17f76691b8ebdc192f0e7028f22c04912bdc9efe (HEAD -> master)
Author: jeffreybiles <bilesjeffrey@gmail.com>
Date:   Thu May 2 09:59:21 2019 -0500

    update the readme to add custom instructions

commit 6e6ab4adb3198b2f0d6b370a63aa6a2d8d217c40
Author: jeffreybiles <bilesjeffrey@gmail.com>
Date:   Thu May 2 09:45:30 2019 -0500

    Our first commit
```

The specifics will be different for you, but the format should be similar.  You'll see

* the commit hash.  Think of this like the key for your save file.
* the author.  This will always be you during this project, but this is very useful data when collaborating.
* the time the commit was made.
* the commit message.

All of these are useful, but the commit message varies the most wildly in usefulness.  If you have nice commit messages that are clear about what has changed in that commit, then navigating your history will be a breeze.

When you're doing looking at the log, press `q` to exit.

## Stashing your Mistakes

Sometimes you make mistakes.  Horrible, horrible mistakes.

Let's make one of those mistake... let's delete our entire config directory.

```bash
$ rm -rf config
```

Oh no!  It's gone!  Our app doesn't run!

First, let's check out status:

```bash
$ git status
  On branch master
  Changes not staged for commit:
    (use "git add/rm <file>..." to update what will be committed)
    (use "git checkout -- <file>..." to discard changes in working directory)

  	deleted:    config/config.exs
  	deleted:    config/dev.exs
  	deleted:    config/prod.exs
  	deleted:    config/test.exs

  no changes added to commit (use "git add" and/or "git commit -a")
```

Cool, so git still knows about the files, even though they're deleted.

Git can do even better... it can make it like the mistake never happened.  It's like going back to your last save file.

```bash
$ git stash -u
  Saved working directory and index state WIP on master: 17f7669 update the readme
```

If you check the status again, you'll see that the files are no longer deleted.

```bash
$ git status
  On branch master
  nothing to commit, working tree clean
```

And if you check your files, you'll see the config directory is back.  Hurrah!

By the way, the `-u` option makes it work with files that were added or deleted.  Without that, it would just handle files that were modified.

## Why Github?

* Create github account (link) (mention bitbucket and gitlab as more secure alternatives, provide links)
* Push up to github
* Create a branch
* Switch branches
* Merge the branch
* Deployment
