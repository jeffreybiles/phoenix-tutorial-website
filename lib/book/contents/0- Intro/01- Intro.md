# Intro

There are lots of great resources for intermediate and advanced developers to learn Elixir and Phoenix, but relatively little for beginners.  In addition, the resources that do exist tend to rush past the core web framework features in order to get to the cool advanced features that set the framework apart, like Channels and OTP.

This book aims to be your first Elixir and Phoenix book, but not your last.  We'll go into the basics of the language and the framework, giving you a solid foundation so you can crank out simple web apps and be prepared to read and understand the books written on more advanced topics.

Some of the advanced developers may be thinking: if you're not going to do Channels and OTP, what's the point of using Elixir and Phoenix?  Let's compare a Phoenix app to an app written in the popular Ruby on Rails framework.  Compared to that app, the Phoenix app is

* An order of magnitude faster (due to Elixir's use of the Erlang VM)
* Significantly less likely to descend into spaghetti code (due to functional programming)
* Prepared to take advantage of advanced features *when their use becomes necessary*

Much of the complexity in your typical Ruby on Rails app comes from trying to coax more performance out of the framework or to mitigate the harmful effects of bad Object-Oriented practices.  Thus, although Phoenix has sometimes been seen as a choice only for more advanced users due to its amazing advanced features (and, when the framework was younger, its relatively rough edges), it actually allows you to stick with the basics for longer into your app's life than most comparable web frameworks.

That said, this is not meant to be your first introduction to programming.  While I don't expect you to have familiarity with Elixir or web programming, I do expect you to know how to put together a simple program in *some* language.  If you don't meet that standard, go [here](page with links to beginner resources) and come back when you're ready.

I hope you're as excited as I am to start writing your first Phoenix app!

---

> **Technobabble: When to use Phoenix vs Other web frameworks?**

> Phoenix is still a newer technology, but it's well past 1.0 and stable enough to run production apps (and the underlying technologies- Elixir and Erlang- are rock solid).

> If you're starting a new project, choose Phoenix!  But if you have a legacy project then there are more tradeoffs to consider.

> I'd say that if you are having performance problems which can't be solved with basic solutions (such as fixing n+1 database queries) then it may be worth it to switch to Phoenix.  High availability requirements are another good reason.  It also may be worth it if your project involves lots of concurrency or sockets- stuff that most languages and frameworks do poorly, but Elixir and Phoenix do really really well.

> If you're investigating Phoenix, then it's likely that you fall into one of those camps.  However, if you're happy with your current tech, or if you're unhappy for different reasons, consider whether the benefits of Phoenix will be worth the cost of a rewrite.
