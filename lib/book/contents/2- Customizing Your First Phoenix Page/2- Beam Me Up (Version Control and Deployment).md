# Beam Me Up (Version Control and Deployment)

This chapter contains a lot of material that isn't directly related to Elixir and Phoenix, but is nonetheless extremely important to know.  It also contains a lot of material that is specific to certain services and operating systems- meaning that I won't be able to provide good instructions for Windows on Linux, and the instructions for these services could change independently of the Phoenix framework's upgrade cycle.

For those reasons, I'll be linking to several external guides that cover these very important subjects much more thoroughly than I could, and which will be more likely to stay up to date and cover all operating systems.  What I'll be writing are the parts that won't change either with time or with switching between operating systems.

So let's dive in!

* What is Version Control?
* Install Git (link) https://www.atlassian.com/git/tutorials/install-git
* Initialize git
* Make a commit, then stash away some changes
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
