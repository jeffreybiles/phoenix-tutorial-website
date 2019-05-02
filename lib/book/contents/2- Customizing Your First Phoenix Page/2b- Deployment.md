## Deployment

"Deployment" is the process of making your app available to the wider world.  In this case, it's getting it to a web server where people can view your website (currently a barely-customized default app) by putting a URL in their browser.

For the purposes of this tutorial we recommend using either Render or Heroku.  They both use git to receive your code, and do a lot of the nitty-gritty of server management for you; perfect for beginners or people who are too busy to bother with handling the fine details.

Both of these options have good online instructions, and I don't really have much to add beyond a comparison of the pros and cons of each.  However, seeing someone else follow the instructions could be useful, so I'll record a video of me deploying an app in the video course.

## Heroku

Heroku is the standard "easy deploy" choice.  Phoenix even has official docs ([https://hexdocs.pm/phoenix/heroku.html](https://hexdocs.pm/phoenix/heroku.html)). You won't really go wrong using Heroku as a starter, and when you're just getting started out it's free.

There are three downsides to using Heroku:

* the hoops you're required to jump through have become slowly more arcane
* it's not built for Phoenix, so you're going to lose some scalability
* it can get expensive later on

## Render

Render is a newer alternative that gets rid of some of the cruft that's built up around Heroku.  In general it's cheaper, but to get started you'll need their $5/month DB plan.

One of the big selling points is that any push to github's master branch will automatically deploy your app... no extra setup, no extra commands.  For a lean team that has a good gitflow-like setup, this can be really nice.

Their official instructions ([https://render.com/docs/deploy-phoenix](https://render.com/docs/deploy-phoenix)) are good, and the founder is very responsive on slack.

## Others

There are plenty of other deployment options.  If you have the technical expertise, you can set up on a custom server and start running stuff.  There's also specialized options like [gigalixir](https://gigalixir.com/).  If you really want video instructions for a specific setup, send me an email and let me know: jeff@happyprogrammer.net.

## Onward!

See you in the next chapter, where we start customizing our app.
