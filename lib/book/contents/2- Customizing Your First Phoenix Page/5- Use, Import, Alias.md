# Bringing In the Code

One of the most important tasks in any programming environment is bringing in code from elsewhere- it lets you reuse functionality and keep everything clean.  Elixir and Phoenix have a series of elegant tools available to do that.

In this chapter we're going to focus on the `use`, `import`, and `alias` keywords and what they specifically bring to our Router and Controller files.  There are, of course, functions beyond this (config files, mix, etc.) that we'll cover later.

If you start to feel lost during this chapter, that's okay.  Just power on through, then come back later when you've had more exposure to the framework.  The main goal with this chapter is that our uses of `use` and `import` feel less magical and arbitrary, so knowing that there is a logic is almost as good as understanding the logic.

If you want, you can consider this entire chapter Technobabble for now, skip it, and continue to treat `use`, `import`, and `alias` as magical constructs.

## use StarTrackerWeb, :router

In the last chapter we had the following Router file:

```elixir
defmodule StarTrackerWeb.Router do
  use StarTrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StarTrackerWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/info", PageController, :info
  end

  # Other scopes may use custom stacks.
  # scope "/api", StarTrackerWeb do
  #   pipe_through :api
  # end
end
```

We explained briefly what each of the macros (`pipeline`, `plug`, `scope`, `pipe_through`, `get`) did, but not where they came from.  They're not defined in the core Elixir libraries... instead, they're all made available by the line `use StarTrackerWeb, :router`.

The first link of the chain can be found in `lib/star_tracker_web.ex`.

```Elixir
defmodule StarTrackerWeb do
  # ...

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  # ...

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
```

The comments with `...` are simply code blocks that I've left out in order to make the explanation more concise.

The path through this code starts with `defmacro __using__`.  That is what is called first by Elixir when someone calls `use ThisModuleName`.  So it takes one argument, which in this case is `:router`.  The only line in `defmacro __using__` then uses that argument to call a function within the module with the name of that argument- in this case, the `router` function.  A convoluted way of doing things, but having this complication once means that every Phoenix app gets to enjoy a nicer syntax every time they use the `use MyAppWeb` interface.

## quote

There are lots of cool complicated things you can do with `quote`, but in this file it sticks to doing one relatively simple thing- taking what's within the `quote do ... end` block and dumping it into the file that called the macro where `quote` is used.

So, in this case, the effect of putting `use StarTrackerWeb, :router` in your file is the same as putting in `use Phoenix.Router`, as well as `import Plug.Conn` and `import Phoenix.Controller`.

Why the added layer of indirection?  Having this indirection allows us to put in "standard" things that will show up in every instance where the macro is used.  It's much easier to type in `use StarTrackerWeb, :router` than all three lines, and if you want to change those lines it's better to have them in one centralized place.  This is more useful for Controllers and Views, since there's generally one Router per Phoenix app, but many Controllers and Views.

---

> **Previously On: Indirection**

> "Indirection" can mean various things in a programming context, but when it's used as in "layer of indirection" people generally mean that there are several function calls that don't seem strictly necessary but are there for organizational purposes.

> There are cases where these organizational purposes are valid and worth the cost of adding a layer of indirection (Phoenix usually makes good choices in this regard), but there are also cases where it's meaningless complication that just makes your program harder to understand.

> One of the marks of an experienced developer is that they understand the pros and cons of adding specific layers of indirection.  For now, just go with Phoenix's defaults unless you have a very compelling reason not to.

---

<!-- paused editing here.  TODO: Keep going -->

So now that we see that this use of `use StarTracker.Web, :router` gives us the same effect as `use Phoenix.Router`, let's see what that command brings us.

## use Phoenix.Router

So far we've gotten all our modules from `StarTracker`- our own web app.  Now we're getting a module from `Phoenix`, so we'll have to dig into where the framework code is stored.

## deps

The path for that is in the `deps` folder.  Your text editor may have that folder greyed out, but it should still be available for browsing.  If your text editor has it completely hidden, you can use the command line (`ls` and `cd` commands) or your OS's file browser to explore.

Within the `deps` are all your app's dependencies, brought in from across the web.  Currently we're only interested in the `phoenix` folder.  Specifically, the file we're looking for has a path of `deps/phoenix/lib/phoenix/router.ex`.

## Phoenix.Router

Here's a simplified version of that file:

```elixir
defmodule Phoenix.Router do
  @http_functions [:get, :post, :put, :patch, :delete, :options, :connect, :trace, :head]
  for verb <- @http_functions do #...

  defmacro __using__(_) do #...
  defmacro match(verb, path, plug, plug_opts, options \\ []) do #...
  defmacro pipeline(plug, do: block) do #...
  defmacro plug(plug, opts \\ []) do #...
  defmacro pipe_through(pipes) do #...

  defmacro resources(path, controller, opts, do: nested_context) do #...
  defmacro resources(path, controller, do: nested_context) do #...
  defmacro resources(path, controller, opts) do #...
  defmacro resources(path, controller) do #...

  defmacro scope(options, do: context) do #...
  defmacro scope(path, options, do: context) do #...
  defmacro scope(path, alias, options, do: context) do #...

  defmacro forward(path, plug, plug_opts \\ [], router_opts \\ []) do #...
end
```

You can see that we're defining all of the macros which we used earlier, including several versions of `scope` (remember: pattern matching based on number of arguments), as well as a couple more we haven't seen yet.

That's enough of a dive into the source code- we won't go into detail on how each of them is defined- although you're welcome to do so if it strikes your fancy.

## use StarTracker.Web, :controller

In our controller we call `use StarTracker.Web, :controller`.  Like in the Router, this takes us to our `web/web.ex` file.

```elixir
defmodule StarTracker.Web do
  # ...
  def controller do
    quote do
      use Phoenix.Controller

      alias StarTracker.Repo
      import Ecto
      import Ecto.Query

      import StarTracker.Router.Helpers
      import StarTracker.Gettext
    end
  end
  # ...
  def router do
    quote do
      use Phoenix.Router
    end
  end
  # ...
  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
```

We see that `controller` is a bit more complex than `router`. Within the `quote` block, instead of just dropping in one line, it drops in 7.  We'll start with the familiar one: `use Phoenix.Controller`.

## use Phoenix.Controller

Here's a highly-compacted version of `Phoenix.Controller`, with 90% of the function names and 100% of the actual code redacted for simplicity's sake (the actual file is 1073 lines long, as of this writing).

```elixir
defmodule Phoenix.Controller do
  #...
  def html(conn, data) do #...
  def redirect(conn, opts) when is_list(opts) do #...

  # ...

  def render(conn, template_or_assigns \\ [])
  def render(conn, template) when is_binary(template) or is_atom(template) do # ...
  def render(conn, assigns) do #...

  def render(conn, template, assigns) when is_atom(template) and (is_map(assigns) or is_list(assigns)) do #...
  def render(conn, template, assigns) when is_binary(template) and (is_map(assigns) or is_list(assigns)) do #...
  def render(conn, view, template) when is_atom(view) and (is_binary(template) or is_atom(template)) do # ...

  def render(conn, view, template, assigns) when is_atom(view) and (is_binary(template) or is_atom(template)) do #...

  #...
end
```

Here we see 7 different definitions of `render` (the one Controller function we've used so far), each differentiated by the number of arguments (arity) as well as some `when` clauses (a particular definition of `render` will only be used if its `when` clause is true).

There are lots more definitions in this file, including `html` and `redirect`, but for now there's nothing else for us to learn here.  Time to look at the other things brought in by `use StarTracker.Web, :controller`.

## alias

The next line is the `controller` function is `alias StarTracker.Repo`.  We haven't used this yet, but the explanation is easy *if you don't worry about what `StarTracker.Repo` actually does*.

Simply put: you can access a set of functions from the `StarTracker.Repo` module, such as `StarTracker.Repo.get`.  With the alias given above, you can leave off the `StarTracker` part, leaving only `Repo.get`.  This makes things more convenient.

You can also give the `as` option to your alias.  `alias StarTracker.Repo, as: Repository` would allow you to call `Repository.get`.  The default usage is equivalent to putting the last part of the aliased module in the `as` option (`alias StarTracker.Repo, as: Repo`).

We'll be using `alias` often in our own code, and we'll recap it the first time that happens.

## import

The rest of the lines are `import` calls.  Like `use`, `import` drops the function definitions directly into the current module's namespace.

What sets them apart: `use` calls the `__using__` callback in order to inject code into the current module, and `import` doesn't.  `import` can also have the `only` option, which takes a list of function names (and their arities) and then only puts those specific functions into the current module's namespace.

We'll be using `import` often in our own code, and we'll recap it the first time that happens.

## Conclusion

So that's how we get all the macros like `render`, `get`, and `scope`.

I hope this demystified some of the Elixir Magic for you.  If not, keep reading- although an understanding of the concepts in this chapter is helpful, it's by no means required, and you can make a great app while still thinking of `use` as just a mysterious line that makes your Router and Controller work.

In the next chapter we're going to further connect the Router, Controller, and Template, and see how they pass data back and forth.
